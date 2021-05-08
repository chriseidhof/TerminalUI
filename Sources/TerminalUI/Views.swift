//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

public typealias Width = Int
public typealias Height = Int

public protocol BuiltinView {
    func size(for proposed: ProposedSize) -> Size
    func render(context: RenderingContext, size: Size)
}

extension BuiltinView {
    public func padding(_ amount: Int = 1) -> some BuiltinView {
        Padding(content: self, amount: amount)
    }
    
    public func border(style: BorderStyle = .default) -> some BuiltinView {
        self.padding(1).background(Border(style: style))
    }
    
    public func frame(width: Int? = nil, height: Int? = nil, alignment: Alignment = .center) -> some BuiltinView {
        FixedFrame(width: width, height: height, alignment: alignment, content: self)
    }
}
