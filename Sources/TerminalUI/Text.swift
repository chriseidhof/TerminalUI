public struct Text: BuiltinView {
    var string: String
    
    public init(_ string: String, color: Color? = nil) {
        self.string = string
    }
    
    var lines: [Substring] {
        string.split(omittingEmptySubsequences: false, whereSeparator: { $0.isNewline })
    }
    
    public func size(for proposed: ProposedSize) -> Size {
        // todo actually fit ourselves?
        let lines = self.lines
        let width = lines.map { $0.count }.max() ?? 0
        let height = lines.count
        return Size(width: width, height: height)
    }
    
    public func render(context: RenderingContext, size: Size) {
        var c = context
        for line in lines {
            c.write(line)
            c.origin.y += 1
        }
    }    
}
