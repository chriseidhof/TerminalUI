//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

import SwiftUI

@propertyWrapper
final class LayoutState<A> {
    var wrappedValue: A
    init(wrappedValue: A) {
        self.wrappedValue = wrappedValue
    }
}

struct HStack: BuiltinView {
    var children: [BuiltinView]
    var alignment: VerticalAlignment = .center
    let spacing: Width? = 0
    @LayoutState var sizes: [Size] = []
    
    func render(context: RenderingContext, size: Size) {
        let stackY = alignment.alignmentID.defaultValue(in: size)
        var currentX: Width = 0
        for idx in children.indices {
            let child = children[idx]
            let childSize = sizes[idx]
            let childY = alignment.alignmentID.defaultValue(in: childSize)
            var c = context
            c.translateBy(Point(x: currentX, y: stackY-childY))
            child.render(context: c, size: childSize)
            currentX += childSize.width
        }
    }
    
    func size(for proposed: ProposedSize) -> Size {
        layout(proposed: proposed)
        let width: Width = sizes.reduce(0) { $0 + $1.width }
        let height: Height = sizes.reduce(0) { max($0, $1.height) }
        return Size(width: width, height: height)
    }
    
    func layout(proposed: ProposedSize) {
        let flexibility: [LayoutInfo] = children.indices.map { idx in
            let child = children[idx]
            let lower = child.size(for: ProposedSize(width: 0, height: proposed.height)).width
            let upper = child.size(for: ProposedSize(width: .max, height: proposed.height)).width
            return LayoutInfo(minWidth: lower, maxWidth: upper, idx: idx, priority: 1)
        }.sorted()
        var groups = flexibility.group(by: \.priority)
        var sizes: [Size] = Array(repeating: .zero, count: children.count)
        let allMinWidths = flexibility.map(\.minWidth).reduce(0,+)
        var remainingWidth = proposed.width! - allMinWidths // TODO force unwrap
        
        while !groups.isEmpty {
            let group = groups.removeFirst()
            remainingWidth += group.map(\.minWidth).reduce(0,+)
            
            var remainingIndices = group.map { $0.idx }
            while !remainingIndices.isEmpty {
                let width = remainingWidth / remainingIndices.count
                let idx = remainingIndices.removeFirst()
                let child = children[idx]
                let size = child.size(for: ProposedSize(width: width, height: proposed.height))
                sizes[idx] = size
                remainingWidth -= size.width
                if remainingWidth < 0 { remainingWidth = 0 }
            }
        }
        self.sizes = sizes
    }
}

struct LayoutInfo: Comparable {
    var minWidth: Width
    var maxWidth: Height
    var idx: Int
    var priority: Double
    
    static func <(_ l: LayoutInfo, _ r: LayoutInfo) -> Bool {
        if l.priority > r.priority { return true }
        if r.priority > l.priority { return false }
        return l.flexibility < r.flexibility
    }
    
    var flexibility: Int {
        maxWidth - minWidth
    }
}



