//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

import Foundation


struct BorderStyle {
    var topLeft = "┌"
    var topRight = "┐"
    var horizontal = "─"
    var vertical = "│"
    var bottomLeft = "└"
    var bottomRight = "┘"
    
    
    static let ascii = BorderStyle(topLeft: "+", topRight: "+", horizontal: "-", vertical: "|", bottomLeft: "+", bottomRight: "+")
}

struct Border<Content: BuiltinView>: BuiltinView {
    var content: Content
    var style = BorderStyle()
    let width: Int = 1
    
    func size(for proposed: Size) -> Size {
        var childProposal = proposed
        childProposal.width -= width*2
        childProposal.height -= width*2
        var result = content.size(for: childProposal)
        result.width += width*2
        result.height += width*2
        return result
    }
    
    func render(context: RenderingContext, size: Size) {
        let topLine = style.topLeft + String(repeating: style.horizontal, count: size.width-2) + style.topRight
        context.write(topLine)
        var c = context
        let vertical = style.vertical + String(repeating: " ", count: size.width-2) + style.vertical
        for _ in 1...size.height-2 {
            c.origin.y += 1
            c.write(vertical)
        }
        c.origin.y += 1
        let bottomLine = style.bottomLeft + String(repeating: style.horizontal, count: size.width-2) + style.bottomRight
        c.write(bottomLine)

        c = context
        c.origin.x += width
        c.origin.y += width
        var s = size
        s.width -= width*2
        s.height -= width*2
        content.render(context: c, size: s)
    }
}
