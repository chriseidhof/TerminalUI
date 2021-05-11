//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

public typealias Width = Int
public typealias Height = Int

public protocol View: BuiltinView {
    associatedtype Body: View
    var body: Body { get }
}

extension Never: View {
    public var body: Never {
        fatalError()
    }
}

extension View {
    public func size(for proposed: ProposedSize) -> Size {
        body.size(for: proposed)
    }
    public func render(context: RenderingContext, size: Size) {
        body.render(context: context, size: size)
    }
}

public protocol BuiltinView {
    func size(for proposed: ProposedSize) -> Size
    func render(context: RenderingContext, size: Size)
}

extension BuiltinView {
    public var body: Never { fatalError() }
}

extension View {
    public func padding(_ amount: Int = 1) -> some View {
        Padding(content: self, insets: EdgeInsets(value: amount))
    }
    
    public func padding(_ insets: EdgeInsets) -> some View {
        Padding(content: self, insets: insets)
    }
    
    public func border(style: BorderStyle = .default) -> some View {
        self.padding(1).background(Border(style: style))
    }
    
    public func frame(width: Int? = nil, height: Int? = nil, alignment: Alignment = .center) -> some View {
        FixedFrame(width: width, height: height, alignment: alignment, content: self)
    }
}
