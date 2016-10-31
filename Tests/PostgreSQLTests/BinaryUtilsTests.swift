import XCTest
@testable import PostgreSQL

class BinaryUtilsTests: XCTestCase {
    static let allTests = [
        ("testConvert", testConvert),
        ("testParseBytes", testParseBytes),
        ("testParseString", testParseString),
        ("testParseInt16", testParseInt16),
        ("testParseInt32", testParseInt32),
        ("testParseInt64", testParseInt64),
        ("testParseFloat32", testParseFloat32),
        ("testParseFloat64", testParseFloat64),
    ]
    
    func testConvert() {
        var int16: Int16 = 123
        let convertedInt16: Int16 = withUnsafeMutablePointer(to: &int16) {
            $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: int16)) { value in
                return PostgresBinaryUtils.convert(value)
            }
        }
        XCTAssertEqual(int16, convertedInt16)
        
        var int32: Int32 = Int32.max
        let convertedInt32: Int32 = withUnsafeMutablePointer(to: &int32) {
            $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: int32)) { value in
                return PostgresBinaryUtils.convert(value)
            }
        }
        XCTAssertEqual(int32, convertedInt32)
        
        var uint64: UInt64 = UInt64.min
        let convertedUInt64: UInt64 = withUnsafeMutablePointer(to: &uint64) {
            $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: uint64)) { value in
                return PostgresBinaryUtils.convert(value)
            }
        }
        XCTAssertEqual(uint64, convertedUInt64)
        
        var double: Double = 123.456
        let convertedDouble: Double = withUnsafeMutablePointer(to: &double) {
            $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: double)) { value in
                return PostgresBinaryUtils.convert(value)
            }
        }
        XCTAssertEqual(double, convertedDouble)
        
        var uuid = UUID().uuid
        let convertedUUID: uuid_t = withUnsafeMutablePointer(to: &uuid) {
            $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: uuid)) { value in
                return PostgresBinaryUtils.convert(value)
            }
        }
        XCTAssertEqual(UUID(uuid: uuid), UUID(uuid: convertedUUID))
    }
    
    func testParseBytes() {
        let testByteArrays: [[UInt8]] = [
            [0xaa, 0xbb, 0x01, 0x00, 0x02, 0xFA],
            [0x12, 0x34, 0x56, 0x78],
            [],
        ]
        
        for bytes in testByteArrays {
            var int8Bytes = bytes.map { Int8(bitPattern: $0) }
            let parsedBytes = PostgresBinaryUtils.parseBytes(value: &int8Bytes, length: bytes.count)
            XCTAssertEqual(bytes, parsedBytes)
        }
    }
    
    func testParseString() {
        let testStrings: [String] = [
            "This a test string",
            "",
            "String with one\ntwo\nthree lines.",
            "A string with some emoticons 😎 👻 🌮",
        ]
        
        // Test null-terminated
        for string in testStrings {
            var stringData = Array(string.utf8CString)
            let parsedString = PostgresBinaryUtils.parseString(value: &stringData, length: stringData.count - 1)
            XCTAssertEqual(string, parsedString)
        }
        
        // Test non-null-terminated
        for string in testStrings {
            var stringData = Array(string.utf8CString)
            stringData.removeLast() // Remove NULL
            let parsedString = PostgresBinaryUtils.parseString(value: &stringData, length: stringData.count)
            XCTAssertEqual(string, parsedString)
        }
    }
    
    func testParseInt16() {
        let testInts: [Int16] = [0, 1, 1, 123, 999, Int16.min, Int16.max]
        
        for int in testInts {
            var bigEndian = int.bigEndian
            let convertedInt: Int16 = withUnsafeMutablePointer(to: &bigEndian) {
                $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: bigEndian)) { value in
                    return PostgresBinaryUtils.parseInt16(value: value)
                }
            }
            XCTAssertEqual(int, convertedInt)
        }
    }
    
    func testParseInt32() {
        let testInts: [Int32] = [0, 1, 1, 123, 999, Int32.min, Int32.max]
        
        for int in testInts {
            var bigEndian = int.bigEndian
            let convertedInt: Int32 = withUnsafeMutablePointer(to: &bigEndian) {
                $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: bigEndian)) { value in
                    return PostgresBinaryUtils.parseInt32(value: value)
                }
            }
            XCTAssertEqual(int, convertedInt)
        }
    }
    
    func testParseInt64() {
        let testInts: [Int64] = [0, 1, 1, 123, 999, Int64.min, Int64.max]
        
        for int in testInts {
            var bigEndian = int.bigEndian
            let convertedInt: Int64 = withUnsafeMutablePointer(to: &bigEndian) {
                $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: bigEndian)) { value in
                    return PostgresBinaryUtils.parseInt64(value: value)
                }
            }
            XCTAssertEqual(int, convertedInt)
        }
    }
    
    func testParseFloat32() {
        let testFloats: [Float32] = [0, 1, 1, 123, 999, 1.23, -456.789, FLT_MIN, FLT_MAX]
        
        for float in testFloats {
            var bigEndian = CFConvertFloat32HostToSwapped(float).v
            let convertedFloat: Float32 = withUnsafeMutablePointer(to: &bigEndian) {
                $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: bigEndian)) { value in
                    return PostgresBinaryUtils.parseFloat32(value: value)
                }
            }
            XCTAssertEqual(float, convertedFloat)
        }
    }
    
    func testParseFloat64() {
        let testFloats: [Float64] = [0, 1, 1, 123, 999, 1.23, -456.789, DBL_MIN, DBL_MAX]
        
        for float in testFloats {
            var bigEndian = CFConvertFloat64HostToSwapped(float).v
            let convertedFloat: Float64 = withUnsafeMutablePointer(to: &bigEndian) {
                $0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: bigEndian)) { value in
                    return PostgresBinaryUtils.parseFloat64(value: value)
                }
            }
            XCTAssertEqual(float, convertedFloat)
        }
    }
}
