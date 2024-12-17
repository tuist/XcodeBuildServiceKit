import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationEnded {
    public let buildNumber: Int64
    public let status: BuildOperationStatus
    public let unknown: MessagePackValue // This might be metrics?

    public init(buildNumber: Int64, status: BuildOperationStatus) {
        self.buildNumber = buildNumber
        self.status = status
        unknown = .nil
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationEnded: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationEnded(self) }
}

// MARK: - Decoding

extension BuildOperationEnded: DecodableRPCPayload {
    public init(args: [MessagePackValue], indexPath: IndexPath) throws {
        guard args.count == 3 else { throw RPCPayloadDecodingError.invalidCount(args.count, indexPath: indexPath) }

        buildNumber = try args.parseInt64(indexPath: indexPath + IndexPath(index: 0))
        status = try args.parseObject(indexPath: indexPath + IndexPath(index: 1))
        unknown = try args.parseUnknown(indexPath: indexPath + IndexPath(index: 2))
    }
}

// MARK: - Encoding

extension BuildOperationEnded: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        [
            .int64(buildNumber),
            .int64(status.rawValue),
            unknown,
        ]
    }
}
