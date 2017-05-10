import CPostgreSQL

class Result {
    enum Status {
        case commandOk
        case tuplesOk
        case copyOut
        case copyIn
        case copyBoth
        case singleTuple
        case badResponse
        case nonFatalError
        case fatalError
        case emptyQuery
        case unknown
        
        init(result: Result.Pointer) {
            switch PQresultStatus(result) {
            case PGRES_COMMAND_OK:
                self = .commandOk
            case PGRES_TUPLES_OK:
                self = .tuplesOk
            case PGRES_SINGLE_TUPLE:
                self = .singleTuple
            case PGRES_COPY_OUT:
                self = .copyOut
            case PGRES_COPY_IN:
                self = .copyIn
            case PGRES_COPY_BOTH:
                self = .copyBoth
            case PGRES_BAD_RESPONSE:
                self = .badResponse
            case PGRES_NONFATAL_ERROR:
                self = .nonFatalError
            case PGRES_FATAL_ERROR:
                self = .fatalError
            case PGRES_EMPTY_QUERY:
                self = .emptyQuery
            default:
                self = .unknown
            }
        }
    }
    
    typealias Pointer = OpaquePointer

    private let pointer: Pointer
    private let configuration: Configuration
    let parsed: [[String: Node]]

    init(configuration: Configuration, pointer: Pointer) {
        self.configuration = configuration
        self.pointer = pointer
        
        var parsed: [[String: Node]] = []
        
        let rowCount = PQntuples(pointer)
        let columnCount = PQnfields(pointer)
        
        if rowCount > 0 && columnCount > 0 {
            for row in 0..<rowCount {
                var item: [String: Node] = [:]
                
                for column in 0..<columnCount {
                    let name = String(cString: PQfname(pointer, Int32(column)))
                    
                    if PQgetisnull(pointer, row, column) == 1 {
                        item[name] = .null
                    } else if let value = PQgetvalue(pointer, row, column) {
                        let type = PQftype(pointer, column)
                        let length = Int(PQgetlength(pointer, row, column))
                        item[name] = Node(
                            configuration: configuration,
                            oid: type,
                            value: value,
                            length: length
                        )
                    } else {
                        item[name] = .null
                    }
                }
                
                parsed.append(item)
            }
        }
        
        self.parsed = parsed
    }
}
