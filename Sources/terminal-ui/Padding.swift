//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

struct Padding<Content: BuiltinView>: BuiltinView {
    var content: Content
    var amount: Int = 1
    
    func childSize(for size: Size) -> Size {
        var childProposal = size
        childProposal.width -= amount*2
        childProposal.height -= amount*2
        return childProposal
    }
    
    func size(for proposed: Size) -> Size {
        var result = content.size(for: childSize(for: proposed))
        result.width += amount*2
        result.height += amount*2
        return result
    }
    
    func render(context: RenderingContext, size: Size) {
        var c = context
        c.translateBy(Point(x: amount, y: amount))
        content.render(context: c, size: childSize(for: size))
    }
}
