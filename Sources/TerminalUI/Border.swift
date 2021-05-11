//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

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

struct Border: BuiltinView, View {
    var style = BorderStyle()
    let width = 1
    
    func size(for proposed: ProposedSize) -> Size {
        return proposed.orDefault
    }
    
    func render(context: RenderingContext, size: Size) {
        guard size.width > 1, size.height > 1 else { return }
        let topLine = style.topLeft + String(repeating: style.horizontal, count: size.width-2) + style.topRight
        context.write(topLine)
        var c = context
        let vertical = style.vertical + String(repeating: " ", count: size.width-2) + style.vertical
        if size.height > 2 {
            for _ in 1...size.height-2 {
                c.translateBy(.init(x: 0, y: 1))
                c.write(vertical)
            }
        }
        c.translateBy(.init(x: 0, y: 1))
        let bottomLine = style.bottomLeft + String(repeating: style.horizontal, count: size.width-2) + style.bottomRight
        c.write(bottomLine)
    }
}
