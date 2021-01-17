import XCTest
@testable import ULID

final class ULIDTests: XCTestCase {
    func testULID() {
        let ulid = ULID.create()

        print(ulid.ulidString)

        XCTAssertFalse(ulid.ulidString.isEmpty)
    }

    static var allTests = [
        ("testULID", testULID),
    ]
}
