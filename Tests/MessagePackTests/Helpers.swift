import Foundation

@testable import MessagePack

extension MessagePackValue {
    static func unpack(_ bytes: [UInt8]) throws -> (value: MessagePackValue, remainder: Subdata) {
        try unpack(Data(bytes))
    }

    static func unpack(_ data: Data) throws -> (value: MessagePackValue, remainder: Subdata) {
        try unpack(Subdata(data: data))
    }
}
