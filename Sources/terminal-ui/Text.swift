struct Text: BuiltinView {
    var string: String
    
    init(_ string: String) {
        self.string = string
    }
    
    var lines: [Substring] {
        string.split(omittingEmptySubsequences: false, whereSeparator: { $0.isNewline })
    }
    
    func size(for proposed: Size) -> Size {
        let lines = self.lines
        let width = lines.map { $0.count }.max() ?? 0
        let height = lines.count
        return Size(width: width, height: height)
    }
    
    func render(context: RenderingContext, size: Size) {
        var c = context
        for line in lines {
            c.write(line)
            c.origin.y += 1
        }
    }
    
}
