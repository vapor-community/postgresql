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
    private let port: String
    private let dbname: String
    private let user: String
    private let password: String
    
    // MARK: - Init

    public init(host: String = "localhost", port: String = "5432", dbname: String, user: String, password: String) {
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

        let values = values ?? []
        
        var types: [Oid] = []
        types.reserveCapacity(values.count)
        
        var paramValues: [[Int8]?] = []
        paramValues.reserveCapacity(values.count)
        
        var lengths: [Int32] = []
        lengths.reserveCapacity(values.count)
        
        var formats: [Int32] = []
        formats.reserveCapacity(values.count)
        
        for value in values {
            let (bytes, oid, format) = value.postgresBindingData
            paramValues.append(bytes)
            types.append(oid?.rawValue ?? 0)
            lengths.append(Int32(bytes?.count ?? 0))
            formats.append(format.rawValue)
        }
        
        let res: Result.ResultPointer = PQexecParams(connection.connection, query, Int32(values.count), types, paramValues.map { UnsafePointer<Int8>($0) }, lengths, formats, DataFormat.binary.rawValue)

        defer {
            PQclear(res)
        }

        switch Status(result: res) {
        case .nonFatalError, .fatalError, .unknown:
            throw DatabaseError.invalidSQL(message: String(cString: PQresultErrorMessage(res)))
            
        case .tuplesOk:
            return Result(resultPointer: res).dictionary
            
        default:
            return []
        }
    }

    public func makeConnection() throws -> Connection {
        return try Connection(host: self.host, port: self.port, dbname: self.dbname, user: self.user, password: self.password)
    }
}
