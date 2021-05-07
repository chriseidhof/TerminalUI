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
        return Size(width: min(proposed.width ?? .max, width), height: min(proposed.height ?? .max, height))
    }
    
    public func render(context: RenderingContext, size: Size) {
        let l = self.lines.prefix(size.height)
        guard let first = l.first else { return }
        var c = context
        c.write(first.truncate(to: size.width))
        for line in lines.dropFirst() {
            c.translateBy(.init(x: 0, y: 1))
            c.write(line.truncate(to: size.width))
        }
    }    
}

extension StringProtocol {
    func truncate(to: Width) -> String {
        guard to > 0 else { return "" }
        if count <= to { return String(self) }
        return self.prefix(to-1) + "…"
    }
}
