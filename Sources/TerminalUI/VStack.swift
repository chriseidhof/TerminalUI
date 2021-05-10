// TODO: this is duplicated between HStack and here, except for the axis. We should abstract away that code?

public struct VStack: BuiltinView {
    var children: [BuiltinView]
    var alignment: HorizontalAlignment = .center
    let spacing: Height? = 0
    @LayoutState var sizes: [Size] = []
    
    public init(alignment: HorizontalAlignment = .center, children: [BuiltinView]) {
        self.children = children
        self.alignment = alignment
    }

    
    public func render(context: RenderingContext, size: Size) {
        let stackX = alignment.alignmentID.defaultValue(in: size)
        var currentY: Height = 0
        for idx in children.indices {
            let child = children[idx]
            let childSize = sizes[idx]
            let childX = alignment.alignmentID.defaultValue(in: childSize)
            var c = context
            c.translateBy(Point(x: stackX-childX, y: currentY))
            child.render(context: c, size: childSize)
            currentY += childSize.height
        }
    }
    
    public func size(for proposed: ProposedSize) -> Size {
        layout(proposed: proposed)
        let width: Width = sizes.reduce(0) { max($0, $1.width) }
        let height: Height = sizes.reduce(0) { $0 + $1.height }
        return Size(width: width, height: height)
    }
    
    func layout(proposed: ProposedSize) {
        let flexibility: [LayoutInfo] = children.indices.map { idx in
            let child = children[idx]
            let lower = child.size(for: ProposedSize(width: proposed.width, height: 0)).height
            let upper = child.size(for: ProposedSize(width: proposed.width, height: .max)).height
            return LayoutInfo(min: lower, max: upper, idx: idx, priority: 1)
        }.sorted()
        var groups = flexibility.group(by: \.priority)
        var sizes: [Size] = Array(repeating: .zero, count: children.count)
        let allMinHeights = flexibility.map(\.min).reduce(0,+)
        var remainingHeight = proposed.height! - allMinHeights // TODO force unwrap
        
        while !groups.isEmpty {
            let group = groups.removeFirst()
            remainingHeight += group.map(\.min).reduce(0,+)
            
            var remainingIndices = group.map { $0.idx }
            while !remainingIndices.isEmpty {
                let height = remainingHeight / remainingIndices.count
                let idx = remainingIndices.removeFirst()
                let child = children[idx]
                let size = child.size(for: ProposedSize(width: proposed.width, height: height))
                sizes[idx] = size
                remainingHeight -= size.height
                if remainingHeight < 0 { remainingHeight = 0 }
            }
        }
        self.sizes = sizes
    }
}
