import CPostgreSQL
import Core

public enum DatabaseError: Error {
    case cannotEstablishConnection(String)
    case indexOutOfRange
    case columnNotFound
    case invalidSQL(message: String)
    case noQuery
    case noResults
}

enum DataFormat : Int32 {
    case string = 0
    case binary = 1
}

public final class Database: ConnInfoInitializable {
    // MARK: - Properties
    public let conninfo: ConnInfo

    // MARK: - Init
    public init(conninfo: ConnInfo) throws {
        self.conninfo = conninfo
    }

    // MARK: - Connection
    public func makeConnection() throws -> Connection {
        return try Connection(conninfo: conninfo)
    }

    // MARK: - Query Execution
    @discardableResult
    public func execute(_ query: String, _ values: [Node]? = [], on connection: Connection? = nil) throws -> [[String: Node]] {
        guard !query.isEmpty else {
            throw DatabaseError.noQuery
        }

        let connection = try connection ?? makeConnection()

        return try connection.execute(query, values)
    }

    // MARK: - LISTEN
    public func listen(to channel: String, callback: @escaping (Notification) -> Void) {
        background {
            do {
                let connection = try self.makeConnection()

                try self.execute("LISTEN \(channel)", on: connection)

                while true {
                    if connection.isClosed == true {
                        throw DatabaseError.cannotEstablishConnection(connection.lastError)
                    }

                    PQconsumeInput(connection.cConnection)

                    while let pgNotify = PQnotifies(connection.cConnection) {
                        let notification = Notification(relname: pgNotify.pointee.relname, extra: pgNotify.pointee.extra, be_pid: pgNotify.pointee.be_pid)

                        callback(notification)

                        PQfreemem(pgNotify)
                    }
                }
            }
            catch {
                fatalError("\(error)")
            }
        }
    }

    // MARK: - NOTIFY
    public func notify(channel: String, payload: String?, on connection: Connection? = nil) throws {
        let connection = try connection ?? makeConnection()

        if let payload = payload {
            try execute("NOTIFY \(channel), '\(payload)'", on: connection)
        }
        else {
            try execute("NOTIFY \(channel)", on: connection)
        }
    }
}
