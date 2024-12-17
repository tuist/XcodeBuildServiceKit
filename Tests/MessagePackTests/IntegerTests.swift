import Foundation
import XCTest

@testable import MessagePack

class IntegerTests: XCTestCase {
    func testPackNegFixint() {
        XCTAssertEqual(MessagePackValue.pack(.int8(-1)), Data([0xFF]))
    }

    func testUnpackNegFixint() throws {
        let unpacked1 = try MessagePackValue.unpack(Data([0xFF]))
        XCTAssertEqual(unpacked1.value, .int8(-1))
        XCTAssertEqual(unpacked1.remainder.count, 0)

        let unpacked2 = try MessagePackValue.unpack(Data([0xE0]))
        XCTAssertEqual(unpacked2.value, .int8(-32))
        XCTAssertEqual(unpacked2.remainder.count, 0)
    }

    func testPackPosFixintSigned() {
        XCTAssertEqual(MessagePackValue.pack(.int8(1)), Data([0xD0, 0x01]))
    }

    func testUnpackPosFixintSigned() throws {
        let unpacked = try MessagePackValue.unpack(Data([0x01]))
        XCTAssertEqual(unpacked.value, .uint8(1))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testPackPosFixintUnsigned() {
        XCTAssertEqual(MessagePackValue.pack(.uint8(42)), Data([0x2A]))
    }

    func testUnpackPosFixintUnsigned() throws {
        let unpacked = try MessagePackValue.unpack(Data([0x2A]))
        XCTAssertEqual(unpacked.value, .uint8(42))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testPackUInt8() {
        XCTAssertEqual(MessagePackValue.pack(.uint8(0xFF)), Data([0xCC, 0xFF]))
    }

    func testUnpackUInt8() throws {
        let unpacked = try MessagePackValue.unpack(Data([0xCC, 0xFF]))
        XCTAssertEqual(unpacked.value, .uint8(0xFF))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testPackUInt16() {
        XCTAssertEqual(MessagePackValue.pack(.uint16(0xFFFF)), Data([0xCD, 0xFF, 0xFF]))
    }

    func testUnpackUInt16() throws {
        let unpacked = try MessagePackValue.unpack(Data([0xCD, 0xFF, 0xFF]))
        XCTAssertEqual(unpacked.value, .uint16(0xFFFF))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testPackUInt32() {
        XCTAssertEqual(MessagePackValue.pack(.uint32(0xFFFF_FFFF)), Data([0xCE, 0xFF, 0xFF, 0xFF, 0xFF]))
    }

    func testUnpackUInt32() throws {
        let unpacked = try MessagePackValue.unpack(Data([0xCE, 0xFF, 0xFF, 0xFF, 0xFF]))
        XCTAssertEqual(unpacked.value, .uint32(0xFFFF_FFFF))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testPackUInt64() {
        XCTAssertEqual(
            MessagePackValue.pack(.uint64(0xFFFF_FFFF_FFFF_FFFF)),
            Data([0xCF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF])
        )
    }

    func testUnpackUInt64() throws {
        let unpacked = try MessagePackValue.unpack(Data([0xCF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]))
        XCTAssertEqual(unpacked.value, .uint64(0xFFFF_FFFF_FFFF_FFFF))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testPackInt8() {
        XCTAssertEqual(MessagePackValue.pack(.int8(-0x7F)), Data([0xD0, 0x81]))
    }

    func testUnpackInt8() throws {
        let unpacked = try MessagePackValue.unpack(Data([0xD0, 0x81]))
        XCTAssertEqual(unpacked.value, .int8(-0x7F))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testPackInt16() {
        XCTAssertEqual(MessagePackValue.pack(.int16(-0x7FFF)), Data([0xD1, 0x80, 0x01]))
    }

    func testUnpackInt16() throws {
        let unpacked = try MessagePackValue.unpack(Data([0xD1, 0x80, 0x01]))
        XCTAssertEqual(unpacked.value, .int16(-0x7FFF))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testPackInt32() {
        XCTAssertEqual(MessagePackValue.pack(.int32(-0x10000)), Data([0xD2, 0xFF, 0xFF, 0x00, 0x00]))
    }

    func testUnpackInt32() throws {
        let unpacked = try MessagePackValue.unpack(Data([0xD2, 0xFF, 0xFF, 0x00, 0x00]))
        XCTAssertEqual(unpacked.value, .int32(-0x10000))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testPackInt64() {
        XCTAssertEqual(
            MessagePackValue.pack(.int64(-0x1_0000_0000)),
            Data([0xD3, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00])
        )
    }

    func testUnpackInt64() throws {
        let unpacked = try MessagePackValue.unpack(Data([0xD3, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00]))
        XCTAssertEqual(unpacked.value, .int64(-0x1_0000_0000))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }

    func testUnpackInsufficientData() {
        let dataArray: [Data] = [Data([0xD0]), Data([0xD1]), Data([0xD2]), Data([0xD3]), Data([0xD4])]
        for data in dataArray {
            do {
                _ = try MessagePackValue.unpack(data)
                XCTFail("Expected unpack to throw")
            } catch {
                XCTAssertEqual(error as? MessagePackUnpackError, .insufficientData)
            }
        }
    }
}
