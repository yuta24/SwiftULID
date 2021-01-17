import Foundation

enum Base32 {
    static let encoding: [String] = [
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "A", "B", "C", "D", "E", "F", "G", "H", "J", "K",
        "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"
    ]

    static let mask = 0xFF
}
