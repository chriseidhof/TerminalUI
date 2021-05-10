import XCTest
@testable import TerminalUI

final class RegressionTests: XCTestCase {
    func testExample() {
        var sample: some BuiltinView {
            Text("Hello")
                .padding()
                .border()
                .padding()
                .border()
        }
        let size = sample.size(for: ProposedSize(width: 20, height: 5))
        sample.render(context: TestContext(), size: size)
        // this used to crash.
    }
}
