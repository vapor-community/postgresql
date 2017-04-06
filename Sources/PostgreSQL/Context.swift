import Node

public final class PostgreSQLContext: Context {
    internal static let shared = PostgreSQLContext()
    fileprivate init() {}
}

extension Context {
    public var isPostgreSQL: Bool {
        guard let _ = self as? PostgreSQLContext else { return false }
        return true
    }
}
