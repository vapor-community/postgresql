import CPostgreSQL
import Core

public final class Database: ConnInfoInitializable {
    
    // MARK: - Enums
    
    public enum Error: Swift.Error {
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
    
    // MARK: - Properties
    
    public let connInfo: ConnInfo

    // MARK: - Init
    
    public init(connInfo: ConnInfo) throws {
        self.connInfo = connInfo
    }

    /// Creates a new connection to
    /// the database that can be reused between executions.
    ///
    /// The connection will close automatically when deinitialized.
    public func makeConnection() throws -> Connection {
        return try Connection(connInfo: connInfo)
    }

    // MARK: - LISTEN/NOTIFY
    
    public func listen(toChannel channel: String, on connection: Connection? = nil, callback: @escaping (Notification) -> Void) {
        background {
            do {
                let connection = try connection ?? self.makeConnection()

                try connection.execute("LISTEN \(channel)")

                while true {
                    if connection.isConnected == false {
                        throw Database.Error.cannotEstablishConnection(connection.lastError)
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
    
    public func notify(channel: String, payload: String? = nil, on connection: Connection? = nil) throws {
        let connection = try connection ?? makeConnection()

        if let payload = payload {
            try connection.execute("NOTIFY \(channel), '\(payload)'")
        }
        else {
            try connection.execute("NOTIFY \(channel)")
        }
    }
}
