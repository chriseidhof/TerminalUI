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
        let l = lines
        guard !l.isEmpty, size.height > 0 else { return }
        var c = context
        for i in 0..<min(size.height, l.endIndex) {
            if i > 0 {
                c.translateBy(.init(x: 0, y: 1))
            }
            let line = lines[i]
            let lastLineBeforeVerticalTruncation = i + 1 == size.height && i + 1 < l.endIndex
            let truncated = line.truncate(to: size.width)
            if lastLineBeforeVerticalTruncation {
                if truncated.count >= size.width {
                    c.write(truncated.dropLast() + "…")
                } else {
                    c.write(truncated + "…")
                }
            } else {
                c.write(truncated)
            }
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
