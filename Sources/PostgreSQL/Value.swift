/**
 Represents the various types of data that PostgreSQL
 rows can contain and that will be returned by the Database.
 */

public enum Value {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Int)
    case null
}
