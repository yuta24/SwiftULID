import Foundation

struct Randomness: Hashable, Equatable {
    static func ==(lhs: Randomness, rhs: Randomness) -> Bool {
        return lhs.value.0 == rhs.value.0
            && lhs.value.1 == rhs.value.1
            && lhs.value.2 == rhs.value.2
            && lhs.value.3 == rhs.value.3
            && lhs.value.4 == rhs.value.4
            && lhs.value.5 == rhs.value.5
            && lhs.value.6 == rhs.value.6
            && lhs.value.7 == rhs.value.7
            && lhs.value.8 == rhs.value.8
            && lhs.value.9 == rhs.value.9
    }

    var value: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    init<G: RandomNumberGenerator>(gen: inout G) {
        let bits16 = UInt16.random(in: .min ... .max, using: &gen)
        let bits64 = UInt64.random(in: .min ... .max, using: &gen)

        self.value = (
            UInt8(truncatingIfNeeded: bits16 >>  8),
            UInt8(truncatingIfNeeded: bits16 >>  0),
            UInt8(truncatingIfNeeded: bits64 >> 56),
            UInt8(truncatingIfNeeded: bits64 >> 48),
            UInt8(truncatingIfNeeded: bits64 >> 40),
            UInt8(truncatingIfNeeded: bits64 >> 32),
            UInt8(truncatingIfNeeded: bits64 >> 24),
            UInt8(truncatingIfNeeded: bits64 >> 16),
            UInt8(truncatingIfNeeded: bits64 >> 8),
            UInt8(truncatingIfNeeded: bits64 >> 0)
        )
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(value.0)
        hasher.combine(value.1)
        hasher.combine(value.2)
        hasher.combine(value.3)
        hasher.combine(value.4)
        hasher.combine(value.5)
        hasher.combine(value.6)
        hasher.combine(value.7)
        hasher.combine(value.8)
        hasher.combine(value.9)
    }
}
