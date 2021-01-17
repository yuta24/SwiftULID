import Foundation

public struct ULID: Hashable, Comparable, CustomStringConvertible {
    public static func create<G: RandomNumberGenerator>(_ date: Date = .init(), gen: inout G) -> ULID {
        return .init(
            timestamp: Timestamp(date),
            randomness: Randomness(gen: &gen)
        )
    }

    public static func create(_ date: Date = .init()) -> ULID {
        var gen = SystemRandomNumberGenerator()
        return .init(
            timestamp: Timestamp(date),
            randomness: Randomness(gen: &gen)
        )
    }

    public static func ==(lhs: ULID, rhs: ULID) -> Bool {
        return lhs.timestamp == rhs.timestamp && lhs.randomness == rhs.randomness
    }

    public static func < (lhs: ULID, rhs: ULID) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }

    public var ulidString: String {
        let timestampBits =
              UInt64(timestamp.value.0) << 40
            | UInt64(timestamp.value.1) << 32
            | UInt64(timestamp.value.2) << 24
            | UInt64(timestamp.value.3) << 16
            | UInt64(timestamp.value.4) <<  8
            | UInt64(timestamp.value.5) <<  0
        let randomnessUppserBits =
              UInt64(randomness.value.0) << 32
            | UInt64(randomness.value.1) << 24
            | UInt64(randomness.value.2) << 18
            | UInt64(randomness.value.3) <<  8
            | UInt64(randomness.value.4) <<  0
        let randomnessLowerBits =
              UInt64(randomness.value.5) << 32
            | UInt64(randomness.value.6) << 24
            | UInt64(randomness.value.7) << 16
            | UInt64(randomness.value.8) <<  8
            | UInt64(randomness.value.9) <<  0

        return encode(timestampBits, count: 10)
            + encode(randomnessUppserBits, count: 8)
            + encode(randomnessLowerBits, count: 8)
    }

    public var description: String {
        return ulidString
    }

    private let timestamp: Timestamp
    private let randomness: Randomness

    public func hash(into hasher: inout Hasher) {
        hasher.combine(timestamp)
        hasher.combine(randomness)
    }

    private func encode<T: BinaryInteger>(_ value: T, count: UInt) -> String {
        let charactors: [String] = (0..<count).map { i in
            let value = value >> ((count - 1 - i) * 5)
            let index = Int(value & 0x1F)
            return Base32.encoding[index]
        }

        return charactors.joined()
    }
}
