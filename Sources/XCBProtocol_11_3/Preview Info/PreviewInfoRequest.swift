import Foundation
import MessagePack
import XCBProtocol

public struct PreviewInfoRequest {
    public let sessionHandle: String
    public let responseChannel: UInt64
    public let buildRequest: BuildRequest // Called `request` by Xcode
    public let targetGUID: String // Called `targetID` by Xcode
    public let sourceFile: String // e.g. "/Full/Path/To/Project/Source/File.swift"
    public let thunkVariantSuffix: String // e.g. "__XCPREVIEW_THUNKSUFFIX__"
}

// MARK: - Decoding

extension PreviewInfoRequest: DecodableRPCPayload {
    public init(args: [MessagePackValue], indexPath: IndexPath) throws {
        guard args.count == 6 else { throw RPCPayloadDecodingError.invalidCount(args.count, indexPath: indexPath) }

        sessionHandle = try args.parseString(indexPath: indexPath + IndexPath(index: 0))
        responseChannel = try args.parseUInt64(indexPath: indexPath + IndexPath(index: 1))
        buildRequest = try args.parseObject(indexPath: indexPath + IndexPath(index: 2))
        targetGUID = try args.parseString(indexPath: indexPath + IndexPath(index: 3))
        sourceFile = try args.parseString(indexPath: indexPath + IndexPath(index: 4))
        thunkVariantSuffix = try args.parseString(indexPath: indexPath + IndexPath(index: 5))
    }
}
