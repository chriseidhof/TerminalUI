//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

import Foundation

public struct BorderStyle {
    
    public var topLeft = "┌"
    public var topRight = "┐"
    public var horizontal = "─"
    public var vertical = "│"
    public var bottomLeft = "└"
    public var bottomRight = "┘"
    
    public static let `default` = BorderStyle()
     
    public static let ascii = BorderStyle(topLeft: "+", topRight: "+", horizontal: "-", vertical: "|", bottomLeft: "+", bottomRight: "+")
}

struct Border: BuiltinView {
    var style = BorderStyle()
    let width = 1
    
    func size(for proposed: ProposedSize) -> Size {
        return proposed.orDefault
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
    }
}
