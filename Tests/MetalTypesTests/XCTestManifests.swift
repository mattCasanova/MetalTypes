import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MathTests.allTests),
        testCase(Float2Tests.allTests),
    ]
}
#endif
