import Foundation
import MessagePack
import XCBProtocol

public struct BuildRequest {
    public let parameters: BuildParameters
    public let configuredTargets: [ConfiguredTarget]
    public let continueBuildingAfterErrors: Bool
    public let hideShellScriptEnvironment: Bool
    public let useParallelTargets: Bool
    public let useImplicitDependencies: Bool
    public let useDryRun: Bool
    public let showNonLoggedProgress: Bool
    public let buildPlanDiagnosticsDirPath: String?
    public let buildCommand: BuildCommand
    public let schemeCommand: SchemeCommand
    public let buildOnlyTheseFiles: MessagePackValue
    public let buildOnlyTheseTargets: MessagePackValue
    public let buildDescriptionID: MessagePackValue
    public let enableIndexBuildArena: Bool
    public let useLegacyBuildLocations: Bool
    public let shouldCollectMetrics: Bool
}

// MARK: - Decoding

extension BuildRequest: DecodableRPCPayload {
    public init(args: [MessagePackValue], indexPath: IndexPath) throws {
        guard args.count == 17 else { throw RPCPayloadDecodingError.invalidCount(args.count, indexPath: indexPath) }

        parameters = try args.parseObject(indexPath: indexPath + IndexPath(index: 0))

        let targetsIndexPath = indexPath + IndexPath(index: 1)
        let targetGUIDsArray = try args.parseArray(indexPath: targetsIndexPath)
        configuredTargets = try targetGUIDsArray.enumerated().map { index, _ in
            try targetGUIDsArray.parseObject(indexPath: targetsIndexPath + IndexPath(index: index))
        }

        continueBuildingAfterErrors = try args.parseBool(indexPath: indexPath + IndexPath(index: 2))
        hideShellScriptEnvironment = try args.parseBool(indexPath: indexPath + IndexPath(index: 3))
        useParallelTargets = try args.parseBool(indexPath: indexPath + IndexPath(index: 4))
        useImplicitDependencies = try args.parseBool(indexPath: indexPath + IndexPath(index: 5))
        useDryRun = try args.parseBool(indexPath: indexPath + IndexPath(index: 6))
        showNonLoggedProgress = try args.parseBool(indexPath: indexPath + IndexPath(index: 7))
        buildPlanDiagnosticsDirPath = try args.parseOptionalString(indexPath: indexPath + IndexPath(index: 8))
        buildCommand = try args.parseObject(indexPath: indexPath + IndexPath(index: 9))
        schemeCommand = try args.parseObject(indexPath: indexPath + IndexPath(index: 10))
        buildOnlyTheseFiles = try args.parseUnknown(indexPath: indexPath + IndexPath(index: 11))
        buildOnlyTheseTargets = try args.parseUnknown(indexPath: indexPath + IndexPath(index: 12))
        buildDescriptionID = try args.parseUnknown(indexPath: indexPath + IndexPath(index: 13))
        enableIndexBuildArena = try args.parseBool(indexPath: indexPath + IndexPath(index: 14))
        useLegacyBuildLocations = try args.parseBool(indexPath: indexPath + IndexPath(index: 15))
        shouldCollectMetrics = try args.parseBool(indexPath: indexPath + IndexPath(index: 16))
    }
}
