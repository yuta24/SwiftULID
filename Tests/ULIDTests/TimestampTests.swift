import XCTest
@testable import ULID

final class TimestampTests: XCTestCase {
    func testTimestamp() {
        let date = Date()
        let timestammp = Timestamp(date)

        let formatter = ISO8601DateFormatter()

        XCTAssertEqual(formatter.string(from: date), formatter.string(from: timestammp.toDate()))
    }

    static var allTests = [
        ("testTimestamp", testTimestamp),
    ]
}
