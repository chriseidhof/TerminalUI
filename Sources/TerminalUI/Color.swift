// See https://en.wikipedia.org/wiki/ANSI_escape_code

public enum Color: Int, RawRepresentable, CaseIterable {
    case black = 30
    case red = 31
    case green = 32
    case yellow = 33
    case blue = 34
    case magenta = 35
    case cyan = 36
    case white = 37
    case brightBlack = 90
    case brightRed = 91
    case brightGreen = 92
    case brightYellow = 93
    case brightBlue = 94
    case brightMagenta = 95
    case brightCyan = 96
    case brightWhite = 97
}

extension Color {
    var foreground: Int {
        rawValue
    }
    
    var background: Int {
        rawValue + 10
    }
}

struct ModifyContext<Content: BuiltinView>: BuiltinView {
    var content: Content
    var modify: (inout RenderingContext) -> ()
    
    func size(for proposed: ProposedSize) -> Size {
        content.size(for: proposed)
    }
    
    func render(context: RenderingContext, size: Size) {
        var c = context
        modify(&c)
        content.render(context: c, size: size)
    }

}

extension BuiltinView {
    public func foregroundColor(_ color: Color? = nil) -> some BuiltinView {
        ModifyContext(content: self, modify: { c in
            c.foregroundColor = color
        })
    }
    
    public func backgroundColor(_ color: Color? = nil) -> some BuiltinView {
        ModifyContext(content: self, modify: { c in
            c.backgroundColor = color
        })
    }
}
