import Foundation
import MessagePack
import XCBProtocol

public struct SetSessionUserInfoRequest {
    public let sessionHandle: String
    public let user: String
    public let group: String
    public let uid: Int64
    public let gid: Int64
    public let home: String
    public let xcodeProcessEnvironment: [String: String]
    public let buildSystemEnvironment: [String: String]
    public let usePerConfigurationBuildDirectories: Bool?
}

// MARK: - Decoding

extension SetSessionUserInfoRequest: DecodableRPCPayload {
    public init(args: [MessagePackValue], indexPath: IndexPath) throws {
        guard args.count == 9 else { throw RPCPayloadDecodingError.invalidCount(args.count, indexPath: indexPath) }

        sessionHandle = try args.parseString(indexPath: indexPath + IndexPath(index: 0))
        user = try args.parseString(indexPath: indexPath + IndexPath(index: 1))
        group = try args.parseString(indexPath: indexPath + IndexPath(index: 2))
        uid = try args.parseInt64(indexPath: indexPath + IndexPath(index: 3))
        gid = try args.parseInt64(indexPath: indexPath + IndexPath(index: 4))
        home = try args.parseString(indexPath: indexPath + IndexPath(index: 5))
        xcodeProcessEnvironment = try args.parseMap(indexPath: indexPath + IndexPath(index: 6))
        buildSystemEnvironment = try args.parseMap(indexPath: indexPath + IndexPath(index: 7))
        usePerConfigurationBuildDirectories = try args.parseOptionalBool(indexPath: indexPath + IndexPath(index: 8))
    }
}
