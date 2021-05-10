//
//  File.swift
//  
//
//  Created by Chris Eidhof on 10.05.21.
//

import TerminalUI

class TestContext: RenderingContext {
    var log: String = ""
    
    var foregroundColor: Color? {
        didSet {
            print("Set foreground color \(String(describing: foregroundColor))", to: &log)
        }
    }
    
    var backgroundColor: Color? {
        didSet {
            print("Set background color \(String(describing: foregroundColor))", to: &log)
        }
    }
    
    func translateBy(_ point: Point) {
        print("translateBy \(point)", to: &log)

    }
    
    func write<S>(_ s: S) where S : StringProtocol {
        print("write \(String(s))", to: &log)
    }
    
    
}

final class ArrayBuffer {
    var result: [[Character]]
    
    var string: String {
        result.map { String($0) }.joined(separator: "\n")
    }
    
    init(size: Size) {
        self.result = Array(repeating: Array(repeating: " ", count: size.width), count: size.height)
    }
}

struct ArrayContext: RenderingContext {
    var buffer: ArrayBuffer
    var point = Point.zero
    
    init(buffer: ArrayBuffer) {
        self.buffer = buffer
    }
    var foregroundColor: Color?
    var backgroundColor: Color?
    
    mutating func translateBy(_ point: Point) {
        self.point.x += point.x
        self.point.y += point.y
    }
    
    func write<S>(_ s: S) where S : StringProtocol {
        assert(!s.contains(where: { $0.isNewline }))
        buffer.result[point.y][point.x..<point.x+s.count] = Array(s)[...]
    }
}
