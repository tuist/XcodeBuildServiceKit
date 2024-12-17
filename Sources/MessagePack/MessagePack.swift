import Foundation

public enum MessagePackValue: Equatable, Hashable {
    case `nil`
    case bool(Bool)
    case int8(Int8)
    case int16(Int16)
    case int32(Int32)
    case int64(Int64)
    case uint8(UInt8)
    case uint16(UInt16)
    case uint32(UInt32)
    case uint64(UInt64)
    case float(Float)
    case double(Double)
    case string(String)
    case binary(Data)
    case array([MessagePackValue])
    case map([MessagePackValue: MessagePackValue])
    case extended(Int8, Data)
}

extension MessagePackValue: CustomStringConvertible {
    public var description: String {
        switch self {
        case .nil:
            return "nil"
        case let .bool(value):
            return "bool(\(value))"
        case let .int8(value):
            return "int8(\(value))"
        case let .int16(value):
            return "int16(\(value))"
        case let .int32(value):
            return "int32(\(value))"
        case let .int64(value):
            return "int64(\(value))"
        case let .uint8(value):
            return "uint8(\(value))"
        case let .uint16(value):
            return "uint16(\(value))"
        case let .uint32(value):
            return "uint32(\(value))"
        case let .uint64(value):
            return "uint64(\(value))"
        case let .float(value):
            return "float(\(value))"
        case let .double(value):
            return "double(\(value))"
        case let .string(string):
            return "string(\(string))"
        case let .binary(data):
            return "data(\(data))"
        case let .array(array):
            return "array(\(array.description))"
        case let .map(dict):
            return "map(\(dict.description))"
        case let .extended(type, data):
            return "extended(\(type), \(data))"
        }
    }
}
