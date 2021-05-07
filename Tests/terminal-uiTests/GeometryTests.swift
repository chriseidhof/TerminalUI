import XCTest
@testable import TerminalUI

final class GeometryTests: XCTestCase {
    func testExample() {
        let x0 = Rect(origin: .zero, size: Size(width: 10, height: 5))
        let x1 = Rect(origin: .zero, size: Size(width: 20, height: 3))
        XCTAssertEqual(x0.union(x1), Rect(origin: .zero, size: Size(width: 20, height: 5)))
        
    }
}
