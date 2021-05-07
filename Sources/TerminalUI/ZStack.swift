public struct ZStack: BuiltinView {
    public init(alignment: Alignment = .center, children: [BuiltinView]) {
        self.alignment = alignment
        self.children = children
    }
    
    var alignment: Alignment = .center
    var children: [BuiltinView]
    @LayoutState var rects: [Rect] = []
        
    public func render(context: RenderingContext, size: Size) {
        assert(rects.count == children.count)
        let selfPoint = alignment.point(for: size)
        let actualRects: [Rect] = rects.map {
            var copy = $0
            copy.origin.x += selfPoint.x
            copy.origin.y += selfPoint.y
            return copy
        }
        let minX = actualRects.map { $0.minX }.min() ?? 0
        let maxY = actualRects.map { $0.maxY }.max() ?? size.height
        var c = context
//        context.saveGState()
        c.translateBy(Point(x: -minX, y: size.height-maxY))
        for i in children.indices {
            let child = children[i]
            var childC = c
            childC.translateBy(Point(x: actualRects[i].origin.x, y: actualRects[i].origin.y))
            child.render(context: childC, size: rects[i].size)
        }
//        context.restoreGState()
    }
    
    
    public func size(for proposed: ProposedSize) -> Size {
        layout(proposed: proposed)
        guard let f = rects.first else { return .zero }
        let union = rects.dropFirst().reduce(f, { $0.union($1) })
        let size = union.size
        layout(proposed: ProposedSize(size))
        return size
    }
    
    func layout(proposed: ProposedSize) {
        rects = Array(repeating: .zero, count: children.count)
        for i in children.indices {
            let child = children[i]
            let childSize = child.size(for: proposed)
            let point = alignment.point(for: childSize)
            rects[i] = Rect(origin: Point(x: -point.x, y: -point.y), size: childSize)
        }
    }
}
