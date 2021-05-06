//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

import Foundation

typealias Width = Int
typealias Height = Int

protocol BuiltinView {
    func size(for proposed: ProposedSize) -> Size
    func render(context: RenderingContext, size: Size)
}

struct ProposedSize {
    var width: Width?
    var height: Height?
}

extension ProposedSize {
    var orDefault: Size {
        return Size(width: width ?? 1, height: height ?? 1)
    }
}

struct Size {
    var width: Width
    var height: Height
    
    static let zero = Size(width: 0, height: 0)
}

extension ProposedSize {
    init(_ size: Size) {
        self.width = size.width
        self.height = size.height
    }
}

extension BuiltinView {
    func padding(_ amount: Int = 1) -> some BuiltinView {
        Padding(content: self, amount: amount)
    }
    
    func border(style: BorderStyle = .init()) -> some BuiltinView {
        Border(content: self, style: style)
    }
    
    func frame(width: Int? = nil, height: Int? = nil, alignment: Alignment = .center) -> some BuiltinView {
        FixedFrame(width: width, height: height, alignment: alignment, content: self)
    }
}
