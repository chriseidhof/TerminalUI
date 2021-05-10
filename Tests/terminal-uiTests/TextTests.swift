import XCTest
@testable import TerminalUI

final class TextTests: XCTestCase {
    var context = TestContext()
    
    override func setUp() {
        context = TestContext()
    }
    
    func testExample() {
        let t = Text("Hello")
        let size = t.size(for: ProposedSize(width: nil, height: nil))
        XCTAssertEqual(size, Size(width: 5, height: 1))
        
    }
    
    func testTruncation() {
        let t = Text("Hello World")
        let size = t.size(for: ProposedSize(width: 5, height: 1))
        XCTAssertEqual(size, Size(width: 5, height: 1))
        t.render(context: context, size: size)
        XCTAssertEqual(context.log, "write Hell…\n")
    }
    
    func testTruncation2() {
        let t = Text("Hello")
        let size = t.size(for: ProposedSize(width: 5, height: 1))
        t.render(context: context, size: size)
        XCTAssertEqual(context.log, "write Hello\n")
    }
    
    func testLineTruncation2() {
        let t = Text("Hello\nWorld")
        let size = t.size(for: ProposedSize(width: 5, height: 1))
        t.render(context: context, size: size)
        XCTAssertEqual(context.log, "write Hell…\n")
    }
    
    func testLineTruncation3() {
        let t = Text("This is a truncation test".split(separator: " ").joined(separator: "\n"))
        let size = t.size(for: ProposedSize(width: 20, height: 1))
        t.render(context: context, size: size)
        XCTAssertEqual(context.log, "write This…\n")
    }
}
