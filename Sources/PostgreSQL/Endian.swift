enum Endian {
    case big
    case little
    
    static let current: Endian = {
        return 42.bigEndian == 42 ? .big : .little
    }()
}
