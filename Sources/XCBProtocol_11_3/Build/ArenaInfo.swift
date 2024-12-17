import Foundation
import MessagePack
import XCBProtocol

public struct ArenaInfo {
    public let derivedDataPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData"
    public let buildProductsPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Build/Products"
    public let buildIntermediatesPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Build/Intermediates.noindex"
    public let pchPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Build/Intermediates.noindex/PrecompiledHeaders"
    public let indexPCHPath: String // e.g.
    // "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Index/PrecompiledHeaders"
    public let indexDataStoreFolderPath: String // e.g.
    // "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Index/DataStore"
    public let indexEnableDataStore: Bool
}

// MARK: - Decoding

extension ArenaInfo: DecodableRPCPayload {
    public init(args: [MessagePackValue], indexPath: IndexPath) throws {
        guard args.count == 7 else { throw RPCPayloadDecodingError.invalidCount(args.count, indexPath: indexPath) }

        derivedDataPath = try args.parseString(indexPath: indexPath + IndexPath(index: 0))
        buildProductsPath = try args.parseString(indexPath: indexPath + IndexPath(index: 1))
        buildIntermediatesPath = try args.parseString(indexPath: indexPath + IndexPath(index: 2))
        pchPath = try args.parseString(indexPath: indexPath + IndexPath(index: 3))
        indexPCHPath = try args.parseString(indexPath: indexPath + IndexPath(index: 4))
        indexDataStoreFolderPath = try args.parseString(indexPath: indexPath + IndexPath(index: 5))
        indexEnableDataStore = try args.parseBool(indexPath: indexPath + IndexPath(index: 6))
    }
}
