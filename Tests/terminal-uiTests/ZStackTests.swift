import XCTest
@testable import TerminalUI

final class ArrayBuffer {
    var result: [[Character]]
    
    var string: String {
        result.map { String($0) }.joined(separator: "\n")
    }
    
    init(size: Size) {
        self.result = Array(repeating: Array(repeating: " ", count: size.width), count: size.height)
    }
}

struct ArrayContext: RenderingContext {
    var buffer: ArrayBuffer
    var point = Point.zero
    
    init(buffer: ArrayBuffer) {
        self.buffer = buffer
    }
    var foregroundColor: Color?
    var backgroundColor: Color?
    
    mutating func translateBy(_ point: Point) {
        self.point.x += point.x
        self.point.y += point.y
    }
    
    func write<S>(_ s: S) where S : StringProtocol {
        assert(!s.contains(where: { $0.isNewline }))
        buffer.result[point.y][point.x..<point.x+s.count] = Array(s)[...]
    }
    
    
}

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
