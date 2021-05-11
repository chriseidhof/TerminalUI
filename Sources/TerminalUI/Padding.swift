//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

struct Padding<Content: View>: View {
    var content: Content
    var insets: EdgeInsets = EdgeInsets(value: 1)
    
    func childSize(for size: Size) -> Size {
        var childProposal = size
        childProposal.width -= (insets.leading + insets.trailing)
        childProposal.height -= (insets.top + insets.bottom)
        return childProposal
    }
    
    func size(for proposed: ProposedSize) -> Size {
        var result = content.size(for: ProposedSize(childSize(for: proposed.orDefault)))
        result.width += (insets.leading + insets.trailing)
        result.height += (insets.top + insets.bottom)
        return result
    }
    
    func render(context: RenderingContext, size: Size) {
        var c = context
        c.translateBy(Point(x: insets.leading, y: insets.top))
        content.render(context: c, size: childSize(for: size))
    }
}
