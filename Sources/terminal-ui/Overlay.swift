
struct Overlay<Content: BuiltinView, O: BuiltinView>: BuiltinView {
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

struct Background<Content: BuiltinView, O: BuiltinView>: BuiltinView {
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

extension BuiltinView {
    func overlay<O: BuiltinView>(_ other: O, alignment: Alignment = .center) -> some BuiltinView {
        Overlay(content: self, overlay: other, alignment: alignment)
    }
    
    func background<O: BuiltinView>(_ other: O, alignment: Alignment = .center) -> some BuiltinView {
        Background(content: self, background: other, alignment: alignment)
    }
}
