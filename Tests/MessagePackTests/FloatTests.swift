import Foundation
import XCTest

@testable import MessagePack

class FloatTests: XCTestCase {
    let packed = Data([0xCA, 0x40, 0x48, 0xF5, 0xC3])

    func testPack() {
        XCTAssertEqual(MessagePackValue.pack(.float(3.14)), packed)
    }

    func testUnpack() throws {
        let unpacked = try MessagePackValue.unpack(packed)
        XCTAssertEqual(unpacked.value, .float(3.14))
        XCTAssertEqual(unpacked.remainder.count, 0)
    }
}
