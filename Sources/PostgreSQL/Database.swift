#if os(Linux)
    import CPostgreSQLLinux
#else
    import CPostgreSQLMac
#endif

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

public class Database {
    // MARK: - Properties
    
    private let host: String
    private let port: Int
    private let dbname: String
    private let user: String
    private let password: String
    
    // MARK: - Init

    public init(
        host: String = "localhost",
        port: Int = 5432,
        dbname: String,
        user: String,
        password: String
    ) {
        self.host = host
        self.port = port
        self.dbname = dbname
        self.user = user
        self.password = password
    }
    
    // MARK: - Connection

    @discardableResult
    public func execute(_ query: String, _ values: [Node]? = [], on connection: Connection? = nil) throws -> [[String: Node]] {
        guard !query.isEmpty else {
            throw DatabaseError.noQuery
        }
        
        let connection = try connection ?? makeConnection()

        return try connection.execute(query, values)
    }

    public func makeConnection() throws -> Connection {
        return try Connection(host: self.host, port: self.port, dbname: self.dbname, user: self.user, password: self.password)
    }
}
