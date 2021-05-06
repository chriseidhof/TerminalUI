import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(terminal_uiTests.allTests),
    ]
}
#endif
