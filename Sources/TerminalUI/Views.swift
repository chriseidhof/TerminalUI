//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

import Foundation

public typealias Width = Int
public typealias Height = Int

public protocol BuiltinView {
    func size(for proposed: ProposedSize) -> Size
    func render(context: RenderingContext, size: Size)
}

public struct ProposedSize: Equatable {
    public var width: Width?
    public var height: Height?
}

extension ProposedSize {
    var orDefault: Size {
        return Size(width: width ?? 1, height: height ?? 1)
    }
}

public struct Size: Equatable {
    public var width: Width
    public var height: Height
     
    public static let zero = Size(width: 0, height: 0)
}

public struct Point: Equatable {
    public var x: Int
    public var y: Int
    
    static let zero = Point(x: 0, y: 0)
}


extension ProposedSize {
    public init(_ size: Size) {
        self.width = size.width
        self.height = size.height
    }
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
