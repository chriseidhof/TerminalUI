//
//  File.swift
//  
//
//  Created by Chris Eidhof on 07.05.21.
//

import Foundation

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

public struct Rect: Equatable {
    public var origin: Point
    public var size: Size
    
    static let zero = Rect(origin: .zero, size: .zero)
}

extension ProposedSize {
    public init(_ size: Size) {
        self.width = size.width
        self.height = size.height
    }
}

extension Rect {
    var minX: Int {
        size.width > 0 ? origin.x : origin.x - size.width
    }
    
    var minY: Int {
        size.height > 0 ? origin.y : origin.y - size.height
    }
    
    var maxX: Int {
        origin.x + size.width
    }
    
    var maxY: Int {
        origin.y + size.height
    }
    
    var standardized: Rect {
        self // todo
    }
    
    func union(_ other: Rect) -> Rect {
        let s = standardized
        let o = other.standardized
        let minX = min(s.minX, o.minX)
        let maxX = max(s.maxX, o.maxX)
        let minY = min(s.minY, o.minY)
        let maxY = max(s.maxY, o.maxY)
        return Rect(origin: Point(x: minX, y: minY), size: Size(width: maxX-minX, height: maxY-minY))
    }
}
