
struct Overlay<Content: View, O: View>: View, BuiltinView {
    let content: Content
    let overlay: O
    let alignment: Alignment
    
    func render(context: RenderingContext, size: Size) {
        content.render(context: context, size: size)
        let childSize = overlay.size(for: ProposedSize(size))
        var c = context
        let t = content.translation(for: overlay, in: size, siblingSize: childSize, alignment: alignment)
        c.translateBy(t)
        overlay.render(context: c, size: childSize)
    }
    
    func size(for proposed: ProposedSize) -> Size {
        content.size(for: proposed)
    }
}

struct Background<Content: View, O: View>: View, BuiltinView {
    let content: Content
    let background: O
    let alignment: Alignment
    
    func render(context: RenderingContext, size: Size) {
        let childSize = background.size(for: ProposedSize(size))
        var c = context
        let t = content.translation(for: background, in: size, siblingSize: childSize, alignment: alignment)
        c.translateBy(t)
        
        background.render(context: c, size: childSize)
        content.render(context: context, size: size)
    }
    
    func size(for proposed: ProposedSize) -> Size {
        content.size(for: proposed)
    }
}

extension View {
    public func overlay<O: View>(_ other: O, alignment: Alignment = .center) -> some View {
        Overlay(content: self, overlay: other, alignment: alignment)
    }
    
    public func background<O: View>(_ other: O, alignment: Alignment = .center) -> some View {
        Background(content: self, background: other, alignment: alignment)
    }
}
