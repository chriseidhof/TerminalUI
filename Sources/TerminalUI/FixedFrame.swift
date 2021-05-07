//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

struct FixedFrame<Content: BuiltinView>: BuiltinView {
    var width: Width?
    var height: Width?
    var alignment: Alignment
    var content: Content    

    func size(for proposed: ProposedSize) -> Size {
        let childSize = content.size(for: ProposedSize(width: width ?? proposed.width, height: height ?? proposed.height))
        return Size(width: width ?? childSize.width, height: height ?? childSize.height)
    }
    
    func render(context: RenderingContext, size: Size) {
        let childSize = content.size(for: ProposedSize(size))
        let t = translation(for: content, in: size, childSize: childSize, alignment: alignment)
        var c = context
        c.translateBy(t)
        content.render(context: c, size: childSize)
    }
}

extension BuiltinView {
    func translation(for childView: BuiltinView, in parentSize: Size, childSize: Size, alignment: Alignment) -> Point {
        let parentPoint = alignment.point(for: parentSize)
        let childPoint = alignment.point(for: childSize)
        return Point(x: parentPoint.x-childPoint.x, y: parentPoint.y-childPoint.y)
    }
    
    func translation<V: BuiltinView>(for sibling: V, in size: Size, siblingSize: Size, alignment: Alignment) -> Point {
        let selfPoint = alignment.point(for: size)
        let childPoint = alignment.point(for: siblingSize)
        return Point(x: selfPoint.x-childPoint.x, y: selfPoint.y-childPoint.y)
    }
}
