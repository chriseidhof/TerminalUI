import XCTest
@testable import TerminalUI

final class ZStackTests: XCTestCase {
    var context = TestContext()
    
    override func setUp() {
        context = TestContext()
    }
    
    func testSimple() {
        let t = ZStack(children: [Text("Hello")])
        let size = t.size(for: ProposedSize(width: nil, height: nil))
        XCTAssertEqual(size, Size(width: 5, height: 1))
        
    }
    
    func testDouble() {
        let t = ZStack(alignment: .center, children: [
            Text("x\n---\nx"),
            Text("+")
        ])
        let size = t.size(for: ProposedSize(width: nil, height: nil))
        XCTAssertEqual(size, Size(width: 3, height: 3))
        let buffer = ArrayBuffer(size: size)
        let c = ArrayContext(buffer: buffer)
        t.render(context: c, size: size)
        XCTAssertEqual(buffer.string, "x  \n-+-\nx  ")
    }
}
