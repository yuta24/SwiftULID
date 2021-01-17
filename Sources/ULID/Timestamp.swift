import Foundation

struct Timestamp: Hashable, Comparable {
    static func ==(lhs: Timestamp, rhs: Timestamp) -> Bool {
        return lhs.value.0 == rhs.value.0
            && lhs.value.1 == rhs.value.1
            && lhs.value.2 == rhs.value.2
            && lhs.value.3 == rhs.value.3
            && lhs.value.4 == rhs.value.4
            && lhs.value.5 == rhs.value.5
    }

    static func < (lhs: Timestamp, rhs: Timestamp) -> Bool {
        return lhs.value < rhs.value
    }

    var value: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    init(_ date: Date) {
        let timestamp = UInt64(date.timeIntervalSince1970 * 1000)

        let bits48 = timestamp & 0xFFFFFFFFFFFF

        self.value = (
            UInt8(truncatingIfNeeded: bits48 >> 40),
            UInt8(truncatingIfNeeded: bits48 >> 32),
            UInt8(truncatingIfNeeded: bits48 >> 24),
            UInt8(truncatingIfNeeded: bits48 >> 16),
            UInt8(truncatingIfNeeded: bits48 >>  8),
            UInt8(truncatingIfNeeded: bits48 >>  0)
        )
    }

    func toDate() -> Date {
        let bits48 =
              UInt64(value.0) << 40
            | UInt64(value.1) << 32
            | UInt64(value.2) << 24
            | UInt64(value.3) << 16
            | UInt64(value.4) <<  8
            | UInt64(value.5) <<  0

        return Date(timeIntervalSince1970: Double(bits48) / 1000)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(value.0)
        hasher.combine(value.1)
        hasher.combine(value.2)
        hasher.combine(value.3)
        hasher.combine(value.4)
        hasher.combine(value.5)
    }
}
