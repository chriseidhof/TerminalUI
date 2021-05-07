import XCTest
@testable import TerminalUI

class TestContext: RenderingContext {
    var log: String = ""
    
    var foregroundColor: Color? {
        didSet {
            print("Set foreground color \(String(describing: foregroundColor))", to: &log)
        }
    }
    
    var backgroundColor: Color? {
        didSet {
            print("Set background color \(String(describing: foregroundColor))", to: &log)
        }
    }
    
    func translateBy(_ point: Point) {
        print("translateBy \(point)", to: &log)

    }
    
    func write<S>(_ s: S) where S : StringProtocol {
        print("write \(String(s))", to: &log)
    }
    
    
}

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
}
