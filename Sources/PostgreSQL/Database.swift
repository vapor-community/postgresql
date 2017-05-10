import CPostgreSQL

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
}
