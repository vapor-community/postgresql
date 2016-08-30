import Foundation

#if os(Linux)
    import CPostgreSQLLinux
#else
    import CPostgreSQLMac
#endif

public class Result {
    public typealias ResultPointer = OpaquePointer
    
    private(set) var resultPointer: ResultPointer?
    
    init(resultPointer: ResultPointer) {
        self.resultPointer = resultPointer
    }
    
    lazy var dictionary: [[String: Value]] = { [unowned self] in
        let rowCount = Int(PQntuples(self.resultPointer))
        let columnCount = Int(PQnfields(self.resultPointer))
        
        guard rowCount > 0 && columnCount > 0 else {
            return []
        }
        
        var parsedData = [[String: Value]]()
        
        for row in 0..<rowCount {
            var item = [String: Value]()
            for column in 0..<columnCount {
                let name = String(cString: PQfname(self.resultPointer, Int32(column)))
                
                if PQgetisnull(self.resultPointer, Int32(row), Int32(column)) == 1 {
                    item[name] = .null
                } else {
                    let value = String(cString: PQgetvalue(self.resultPointer, Int32(row), Int32(column))) 
                    let type = PQftype(self.resultPointer, Int32(column))
                    item[name] = Value(oid: type, value: value)
                    
                }
            }
            parsedData.append(item)
        }
        
        return parsedData
    }()
}

