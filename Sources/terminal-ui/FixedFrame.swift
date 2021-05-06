//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

struct Frame<Content: BuiltinView>: BuiltinView {
    var width: Int?
    var height: Int?
    var content: Content
    
    func size(for proposed: Size) -> Size {
        var child = proposed
        child.width = width ?? proposed.width
        child.height = height ?? proposed.height
        var result = content.size(for: child)
        result.width = width ?? result.width
        result.height = height ?? result.height
        return result
    }
    
    func render(context: RenderingContext, size: Size) {
        // center align
        let childSize = content.size(for: size)
        var c = context
        c.translateBy(Point(x: (size.width-childSize.width)/2,
                                  y: (size.height-childSize.height)/2))
        content.render(context: c, size: childSize)
    }
}
