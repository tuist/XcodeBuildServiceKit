import Foundation

// swiftlint:disable function_body_length

extension MessagePackValue {
    /// Packs an integer into a byte array.
    ///
    /// - parameter value: The integer to split.
    /// - parameter parts: The number of bytes into which to split.
    ///
    /// - returns: An byte array representation.
    static func packInteger(_ value: UInt64, parts: Int) -> Data {
        precondition(parts > 0)
        let bytes = stride(from: 8 * (parts - 1), through: 0, by: -8).map { shift in
            UInt8(truncatingIfNeeded: value >> UInt64(shift))
        }
        return Data(bytes)
    }

    /// Packs a `MessagePackValue` into an array of bytes.
    ///
    /// - parameter value: The value to encode
    ///
    /// - returns: A MessagePack byte representation.
    static func pack(_ value: MessagePackValue) -> Data {
        switch value {
        case .nil:
            return Data([0xC0])

        case let .bool(value):
            return Data([value ? 0xC3 : 0xC2])

        case let .int8(value):
            if value < 0, value >= -0x20 {
                // negative fixnum
                return Data([0xE0 + 0x1F & UInt8(truncatingIfNeeded: value)])
            } else {
                return Data([0xD0, UInt8(bitPattern: value)])
            }

        case let .int16(value):
            return Data([0xD1]) + packInteger(UInt64(bitPattern: Int64(value)), parts: 2)

        case let .int32(value):
            return Data([0xD2]) + packInteger(UInt64(bitPattern: Int64(value)), parts: 4)

        case let .int64(value):
            return Data([0xD3]) + packInteger(UInt64(bitPattern: Int64(value)), parts: 8)

        case let .uint8(value):
            if value <= 0x7F {
                // positive fixnum
                return Data([value])
            } else {
                return Data([0xCC, value])
            }

        case let .uint16(value):
            return Data([0xCD]) + packInteger(UInt64(value), parts: 2)

        case let .uint32(value):
            return Data([0xCE]) + packInteger(UInt64(value), parts: 4)

        case let .uint64(value):
            return Data([0xCF]) + packInteger(value, parts: 8)

        case let .float(value):
            return Data([0xCA]) + packInteger(UInt64(value.bitPattern), parts: 4)

        case let .double(value):
            return Data([0xCB]) + packInteger(value.bitPattern, parts: 8)

        case let .string(string):
            let utf8 = string.utf8
            let count = UInt32(utf8.count)
            precondition(count <= 0xFFFF_FFFF as UInt32)

            let prefix: Data
            if count <= 0x1F {
                prefix = Data([0xA0 | UInt8(count)])
            } else if count <= 0xFF {
                prefix = Data([0xD9, UInt8(count)])
            } else if count <= 0xFFFF {
                prefix = Data([0xDA]) + packInteger(UInt64(count), parts: 2)
            } else {
                prefix = Data([0xDB]) + packInteger(UInt64(count), parts: 4)
            }

            return prefix + utf8

        case let .binary(data):
            let count = UInt32(data.count)
            precondition(count <= 0xFFFF_FFFF as UInt32)

            let prefix: Data
            if count <= 0xFF {
                prefix = Data([0xC4, UInt8(count)])
            } else if count <= 0xFFFF {
                prefix = Data([0xC5]) + packInteger(UInt64(count), parts: 2)
            } else {
                prefix = Data([0xC6]) + packInteger(UInt64(count), parts: 4)
            }

            return prefix + data

        case let .array(array):
            let count = UInt32(array.count)
            precondition(count <= 0xFFFF_FFFF as UInt32)

            let prefix: Data
            if count <= 0xF {
                prefix = Data([0x90 | UInt8(count)])
            } else if count <= 0xFFFF {
                prefix = Data([0xDC]) + packInteger(UInt64(count), parts: 2)
            } else {
                prefix = Data([0xDD]) + packInteger(UInt64(count), parts: 4)
            }

            return prefix + array.flatMap(pack)

        case let .map(dict):
            let count = UInt32(dict.count)
            precondition(count < 0xFFFF_FFFF)

            var prefix: Data
            if count <= 0xF {
                prefix = Data([0x80 | UInt8(count)])
            } else if count <= 0xFFFF {
                prefix = Data([0xDE]) + packInteger(UInt64(count), parts: 2)
            } else {
                prefix = Data([0xDF]) + packInteger(UInt64(count), parts: 4)
            }

            return prefix + dict.flatMap { [$0, $1] }.flatMap(pack)

        case let .extended(type, data):
            let count = UInt32(data.count)
            precondition(count <= 0xFFFF_FFFF as UInt32)

            let unsignedType = UInt8(bitPattern: type)
            var prefix: Data
            switch count {
            case 1:
                prefix = Data([0xD4, unsignedType])
            case 2:
                prefix = Data([0xD5, unsignedType])
            case 4:
                prefix = Data([0xD6, unsignedType])
            case 8:
                prefix = Data([0xD7, unsignedType])
            case 16:
                prefix = Data([0xD8, unsignedType])
            case let count where count <= 0xFF:
                prefix = Data([0xC7, UInt8(count), unsignedType])
            case let count where count <= 0xFFFF:
                prefix = Data([0xC8]) + packInteger(UInt64(count), parts: 2) + Data([unsignedType])
            default:
                prefix = Data([0xC9]) + packInteger(UInt64(count), parts: 4) + Data([unsignedType])
            }

            return prefix + data
        }
    }

    /// Packs the `MessagePackValue` into an array of bytes.
    ///
    /// - returns: A MessagePack byte representation.
    public func pack() -> Data {
        Self.pack(self)
    }
}
