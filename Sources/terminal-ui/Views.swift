//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

import Foundation

protocol BuiltinView {
    func size(for proposed: Size) -> Size
    func render(context: RenderingContext, size: Size)
}


extension BuiltinView {
    func padding(_ amount: Int = 1) -> some BuiltinView {
        Padding(content: self, amount: amount)
    }
    
    func border(style: BorderStyle = .init()) -> some BuiltinView {
        Border(content: self, style: style)
    }
    
    func frame(width: Int? = nil, height: Int? = nil) -> some BuiltinView {
        Frame(width: width, height: height, content: self)
    }
}
