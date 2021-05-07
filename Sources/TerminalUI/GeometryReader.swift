public struct GeometryReader<Content: BuiltinView>: BuiltinView {
    public init(alignment: Alignment = Alignment.topLeading, content: @escaping (Size) -> Content) {
        self.alignment = alignment
        self.content = content
    }
    
    var alignment = Alignment.topLeading
    let content: (Size) -> Content
    
    public func render(context: RenderingContext, size: Size) {
        let child = content(size)
        let childSize = child.size(for: ProposedSize(size))
        let parentPoint = alignment.point(for: size)
        let childPoint = alignment.point(for: childSize)
        var c = context
        c.translateBy(Point(x: parentPoint.x-childPoint.x, y: parentPoint.y-childPoint.y))
        child.render(context: c, size: childSize)
    }
    
    public func size(for proposed: ProposedSize) -> Size {
        return proposed.orDefault
    }
}
