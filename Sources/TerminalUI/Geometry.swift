//
//  File.swift
//  
//
//  Created by Chris Eidhof on 07.05.21.
//

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
    
    static public let zero = Point(x: 0, y: 0)
}

public struct Rect: Equatable {
    public var origin: Point
    public var size: Size
    
    static public let zero = Rect(origin: .zero, size: .zero)
}

extension ProposedSize {
    public init(_ size: Size) {
        self.width = size.width
        self.height = size.height
    }
}

public struct EdgeInsets: Equatable {
    public init(leading: Width, trailing: Width, top: Height, bottom: Height) {
        self.leading = leading
        self.trailing = trailing
        self.top = top
        self.bottom = bottom
    }
    
    public init(value: Width) {
        self.leading = value
        self.trailing = value
        self.top = value
        self.bottom = value
    }
    
    public var leading: Width
    public var trailing: Width
    public var top: Height
    public var bottom: Height
}

extension Rect {
    public var minX: Int {
        size.width > 0 ? origin.x : origin.x - size.width
    }
    
    public var minY: Int {
        size.height > 0 ? origin.y : origin.y - size.height
    }
    
    public var maxX: Int {
        origin.x + size.width
    }
    
    public var maxY: Int {
        origin.y + size.height
    }
    
    public var standardized: Rect {
        self // todo
    }
    
    public func union(_ other: Rect) -> Rect {
        let s = standardized
        let o = other.standardized
        let minX = min(s.minX, o.minX)
        let maxX = max(s.maxX, o.maxX)
        let minY = min(s.minY, o.minY)
        let maxY = max(s.maxY, o.maxY)
        return Rect(origin: Point(x: minX, y: minY), size: Size(width: maxX-minX, height: maxY-minY))
    }
}
