public enum ConnInfo {
    case raw(String)
    case params([String: String])
    case basic(hostname: String, port: Int, database: String, user: String, password: String)
}

public protocol ConnInfoInitializable {
    init(connInfo: ConnInfo) throws
}

extension ConnInfoInitializable {
    public init(connInfo: String) throws {
        try self.init(connInfo: .raw(connInfo))
    }
    
    public init(params: [String: String]) throws {
        try self.init(connInfo: .params(params))
    }

    public init(hostname: String, port: Int = 5432, database: String, user: String, password: String) throws {
        try self.init(connInfo: .basic(hostname: hostname, port: port, database: database, user: user, password: password))
    }
}
