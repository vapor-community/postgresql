import CPostgreSQL

public enum ConnInfo {
    case raw(String)
    case params([String: String])
    case basic(hostname: String, port: Int, database: String, user: String, password: String)
}

public protocol ConnInfoInitializable {
    init(conninfo: ConnInfo) throws
}

extension ConnInfoInitializable {
    public init(params: [String: String]) throws {
        try self.init(conninfo: .params(params))
    }

    public init(hostname: String, port: Int, database: String, user: String, password: String) throws {
        try self.init(conninfo: .basic(hostname: hostname, port: port, database: database, user: user, password: password))
    }

    public init(conninfo: String) throws {
        try self.init(conninfo: .raw(conninfo))
    }
}
