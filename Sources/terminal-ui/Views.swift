//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

import Foundation

protocol Builtin {
    func size(for proposed: Size) -> Size
    func render(origin: Point, size: Size)
}

struct Text: Builtin {
    init(_ string: String) {
        self.string = string
    }
    
    func render(origin: Point, size: Size) {
        var p = origin
        for line in lines {
            move(to: p)
            _write(String(line))
            p.y += 1
        }
    }
    
    var string: String
        
    var lines: [Substring] {
        string.split(omittingEmptySubsequences: false, whereSeparator: { $0.isNewline })
    }
    
    func size(for proposed: Size) -> Size {
        let lines = self.lines
        let width = lines.map { $0.count }.max() ?? 0
        let height = lines.count
        return Size(width: width, height: height)
    }
}

struct BorderStyle {
    var topLeft = "┌"
    var topRight = "┐"
    var horizontal = "─"
    var vertical = "│"
    var bottomLeft = "└"
    var bottomRight = "┘"
    
    
    static let ascii = BorderStyle(topLeft: "+", topRight: "+", horizontal: "-", vertical: "|", bottomLeft: "+", bottomRight: "+")
}

struct Border<Content: Builtin>: Builtin {
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
    
    func render(origin: Point, size: Size) {
        move(to: origin)
        let topLine = style.topLeft + String(repeating: style.horizontal, count: size.width-2) + style.topRight
        _write(topLine)
        let vertical = style.vertical + String(repeating: " ", count: size.width-2) + style.vertical
        for v in 1...size.height-2 {
            var p = origin
            p.y += v
            move(to: p)
            _write(vertical)
        }

        var pos = origin
        pos.x += width
        pos.y += width
        var s = size
        s.width -= width*2
        s.height -= width*2
        content.render(origin: pos, size: s)
        pos.x = origin.x
        pos.y = origin.y + size.height-1
        move(to: pos)
        let bottomLine = style.bottomLeft + String(repeating: style.horizontal, count: size.width-2) + style.bottomRight
        _write(bottomLine)
    }
}

struct Padding<Content: Builtin>: Builtin {
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
    
    func render(origin: Point, size: Size) {
        var pos = origin
        pos.x += amount
        pos.y += amount
        content.render(origin: pos, size: childSize(for: size))
    }
}

extension Builtin {
    func padding(_ amount: Int = 1) -> some Builtin {
        Padding(content: self, amount: amount)
    }
    
    func border(style: BorderStyle = .init()) -> some Builtin {
        Border(content: self, style: style)
    }
    
    func frame(width: Int? = nil, height: Int? = nil) -> some Builtin {
        Frame(width: width, height: height, content: self)
    }
}

struct Frame<Content: Builtin>: Builtin {
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
    
    func render(origin: Point, size: Size) {
        // center align
        let childSize = content.size(for: size)
        var p = origin
        p.x += (size.width-childSize.width)/2
        p.y += (size.height-childSize.height)/2
        content.render(origin: p, size: childSize)
    }
}
