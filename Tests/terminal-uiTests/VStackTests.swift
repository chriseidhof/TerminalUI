//
//  File.swift
//  
//
//  Created by Chris Eidhof on 10.05.21.
//

@testable import TerminalUI
import XCTest



final class VStackTests: XCTestCase {
    func testExample() {
        let c = TestContext()
        let rootView =
            VStack(children: [
                Text("Hello"),
                Text("World")
            ])
        let s = rootView.size(for: ProposedSize(width: 20, height: 5))
        XCTAssertEqual(s, Size(width: 5, height: 2))
        rootView.render(context: c, size: s)
        let result = """
        translateBy Point(x: 0, y: 0)
        write Hello
        translateBy Point(x: 0, y: 1)
        write World

        """
        XCTAssertEqual(result, c.log)
    }
}
