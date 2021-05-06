//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

struct FlexibleFrame<Content: BuiltinView>: BuiltinView {
    var minWidth: Width?
    var idealWidth: Width?
    var maxWidth: Width?
    var minHeight: Height?
    var idealHeight: Height?
    var maxHeight: Height?
    var alignment: Alignment
    var content: Content
    
    func size(for p: ProposedSize) -> Size {
        var proposed = ProposedSize(width: p.width ?? idealWidth, height: p.height ??  idealHeight).orDefault
        if let min = minWidth, min > proposed.width {
            proposed.width = min
        }
        if let max = maxWidth, max <  proposed.width {
            proposed.width = max
        }
        if let min = minHeight, min > proposed.height {
            proposed.height = min
        }
        if let max = maxHeight, max <  proposed.height {
            proposed.height = max
        }
        var result = content.size(for: ProposedSize(proposed))
        if let m = minWidth {
            result.width = max(m, min(result.width, proposed.width))
        }
        if let m = maxWidth {
            result.width = min(m, max(result.width, proposed.width))
        }
        if let m = minHeight {
            result.height = max(m, min(result.height, proposed.height))
        }
        if let m = maxHeight {
            result.height = min(m, max(result.height, proposed.height))
        }
        return result
    }
    
    func render(context: RenderingContext, size: Size) {
        var c = context
        let childSize = content.size(for: ProposedSize(size))
        let t = translation(for: content, in: size, childSize: childSize, alignment: alignment)
        c.translateBy(t)
        content.render(context: c, size: childSize)
    }
}

extension BuiltinView {
    func frame(minWidth: Width? = nil, idealWidth: Width? = nil, maxWidth: Width? = nil, minHeight: Height? = nil, idealHeight: Height? = nil, maxHeight: Height? = nil, alignment: Alignment = .center) -> some BuiltinView {
        FlexibleFrame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment, content: self)
    }
}
