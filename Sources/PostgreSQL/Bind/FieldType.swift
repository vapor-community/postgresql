import CPostgreSQL

public enum FieldType : ExpressibleByNilLiteral, Equatable {
    case supported(Supported)
    case array(ArraySupported)
    case unsupported(Oid)
    case null
    
    // MARK: - Init
    
    public init(_ oid: Oid) {
        if let supported = Supported(rawValue: oid) {
            self = .supported(supported)
        }
        else if let arraySupported = ArraySupported(rawValue: oid) {
            self = .array(arraySupported)
        }
        else {
            self = .unsupported(oid)
        }
    }
    
    public init(_ oid: Oid?) {
        if let oid = oid {
            self.init(oid)
        }
        else {
            self.init(nilLiteral: ())
        }
    }
    
    public init(_ supported: Supported) {
        self = .supported(supported)
    }
    
    // MARK: - ExpressibleByNilLiteral
    
    public init(nilLiteral: ()) {
        self = .null
    }
    
    // MARK: - Equatable
    
    public static func ==(lhs: FieldType, rhs: FieldType) -> Bool {
        return lhs.oid == rhs.oid
    }
    
    // MARK: - Oid
    
    public var oid: Oid? {
        switch self {
        case .supported(let supported):
            return supported.rawValue
            
        case .unsupported(let oid):
            return oid
            
        case .array(let supported):
            return supported.rawValue
            
        case .null:
            return nil
        }
    }
}

extension FieldType {
    /// Oid values can be found in the following file:
    /// https://github.com/postgres/postgres/blob/55c3391d1e6a201b5b891781d21fe682a8c64fe6/src/include/catalog/pg_type.h
    public enum Supported: Oid {
        case bool = 16
        
        case int2 = 21
        case int4 = 23
        case int8 = 20
        
        case bytea = 17
        
        case char = 18
        case name = 19
        case text = 25
        case bpchar = 1042
        case varchar = 1043
        
        case json = 114
        case jsonb = 3802
        case xml = 142
        
        case float4 = 700
        case float8 = 701
        
        case numeric = 1700
        
        case date = 1082
        case time = 1083
        case timetz = 1266
        case timestamp = 1114
        case timestamptz = 1184
        case interval = 1186
        
        case uuid = 2950
        
        case point = 600
        case lseg = 601
        case path = 602
        case box = 603
        case polygon = 604
        case circle = 718
        
        case cidr = 650
        case inet = 869
        case macaddr = 829
        
        case bit = 1560
        case varbit = 1562
    }
}

extension FieldType {
    public enum ArraySupported: Oid {
        case bool = 1000
        
        case int2 = 1005
        case int4 = 1007
        case int8 = 1016
        
        case bytea = 1001
        
        case char = 1002
        case name = 1003
        case text = 1009
        case bpchar = 1014
        case varchar = 1015
        
        case json = 199
        case jsonb = 3807
        case xml = 143
        
        case float4 = 1021
        case float8 = 1022
        
        case numeric = 1231
        
        case date = 1182
        case time = 1183
        case timetz = 1270
        case timestamp = 1115
        case timestamptz = 1185
        case interval = 1187
        
        case uuid = 2951
        
        case point = 1017
        case lseg = 1018
        case path = 1019
        case box = 1020
        case polygon = 1027
        case circle = 719
        
        case cidr = 651
        case inet = 1041
        case macaddr = 1040
        
        case bit = 1561
        case varbit = 1563
        
        // MARK: - Supported
        
        public init(_ supported: Supported) {
            switch supported {
            case .bool: self = .bool
            case .int2: self = .int2
            case .int4: self = .int4
            case .int8: self = .int8
            case .bytea: self = .bytea
            case .char: self = .char
            case .name: self = .name
            case .text: self = .text
            case .bpchar: self = .bpchar
            case .varchar: self = .varchar
            case .json: self = .json
            case .jsonb: self = .jsonb
            case .xml: self = .xml
            case .float4: self = .float4
            case .float8: self = .float8
            case .numeric: self = .numeric
            case .date: self = .date
            case .time: self = .time
            case .timetz: self = .timetz
            case .timestamp: self = .timestamp
            case .timestamptz: self = .timestamptz
            case .interval: self = .interval
            case .uuid: self = .uuid
            case .point: self = .point
            case .lseg: self = .lseg
            case .path: self = .path
            case .box: self = .box
            case .polygon: self = .polygon
            case .circle: self = .circle
            case .cidr: self = .cidr
            case .inet: self = .inet
            case .macaddr: self = .macaddr
            case .bit: self = .bit
            case .varbit: self = .varbit
            }
        }
        
        public var supported: Supported {
            switch self {
            case .bool: return .bool
            case .int2: return .int2
            case .int4: return .int4
            case .int8: return .int8
            case .bytea: return .bytea
            case .char: return .char
            case .name: return .name
            case .text: return .text
            case .bpchar: return .bpchar
            case .varchar: return .varchar
            case .json: return .json
            case .jsonb: return .jsonb
            case .xml: return .xml
            case .float4: return .float4
            case .float8: return .float8
            case .numeric: return .numeric
            case .date: return .date
            case .time: return .time
            case .timetz: return .timetz
            case .timestamp: return .timestamp
            case .timestamptz: return .timestamptz
            case .interval: return .interval
            case .uuid: return .uuid
            case .point: return .point
            case .lseg: return .lseg
            case .path: return .path
            case .box: return .box
            case .polygon: return .polygon
            case .circle: return .circle
            case .cidr: return .cidr
            case .inet: return .inet
            case .macaddr: return .macaddr
            case .bit: return .bit
            case .varbit: return .varbit
            }
        }
    }
}
