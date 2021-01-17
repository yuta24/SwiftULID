import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ULIDTests.allTests),
        testCase(TimeStampTests.allTests),
    ]
}
#endif
