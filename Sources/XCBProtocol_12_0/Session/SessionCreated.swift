import Foundation
import MessagePack
import XCBProtocol

public struct SessionCreated {
    public let sessionHandle: String
    public let unknown: MessagePackValue

    public init(sessionHandle: String) {
        self.sessionHandle = sessionHandle
        unknown = .array([])
    }
}

// MARK: - ResponsePayloadConvertible

extension SessionCreated: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .sessionCreated(self) }
}

// MARK: - Decoding

extension SessionCreated: DecodableRPCPayload {
    public init(args: [MessagePackValue], indexPath: IndexPath) throws {
        guard args.count == 2 else { throw RPCPayloadDecodingError.invalidCount(args.count, indexPath: indexPath) }

        sessionHandle = try args.parseString(indexPath: indexPath + IndexPath(index: 0))
        unknown = try args.parseUnknown(indexPath: indexPath + IndexPath(index: 1))
    }
}

// MARK: - Encoding

extension SessionCreated: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        [
            .string(sessionHandle),
            unknown,
        ]
    }
}
