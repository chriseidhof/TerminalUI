struct Alignment {
    var horizontal: HorizontalAlignment
    var vertical: VerticalAlignment

    static let center = Self(horizontal: .center, vertical: .center)
    static let leading = Self(horizontal: .leading, vertical: .center)
    static let trailing = Self(horizontal: .trailing, vertical: .center)
    static let top = Self(horizontal: .center , vertical: .top)
    static let topLeading = Self(horizontal: .leading, vertical: .top)
    static let topTrailing = Self(horizontal: .trailing, vertical: .top)
    static let bottom = Self(horizontal: .center , vertical: .bottom)
    static let bottomLeading = Self(horizontal: .leading, vertical: .bottom)
    static let bottomTrailing = Self(horizontal: .trailing, vertical: .bottom)
}

struct HorizontalAlignment {
    var alignmentID:  AlignmentID.Type
    var builtin: Bool
    static let leading = Self(alignmentID: HLeading.self, builtin: true)
    static let center = Self(alignmentID: HCenter.self, builtin: true)
    static let trailing = Self(alignmentID: HTrailing.self, builtin: true)
}

// We don't allow custom alignments for now
extension HorizontalAlignment {
    fileprivate init(alignmentID: AlignmentID.Type) {
        self.init(alignmentID: alignmentID, builtin: false)
    }
}

extension VerticalAlignment {
    fileprivate init(alignmentID: AlignmentID.Type) {
        self.init(alignmentID: alignmentID, builtin: false)
    }
}

struct VerticalAlignment {
    var alignmentID:  AlignmentID.Type
    var builtin: Bool
    
    static let top = Self(alignmentID: VTop.self, builtin: true)
    static let center = Self(alignmentID: VCenter.self, builtin: true)
    static let bottom = Self(alignmentID: VBottom.self, builtin: true)
}

protocol AlignmentID {
    static func defaultValue(in context: Size) -> Int
}

enum VTop: AlignmentID {
    static func defaultValue(in context: Size) -> Int {
        0
    }
}

enum VCenter: AlignmentID {
    static func defaultValue(in context: Size) -> Int { context.height/2 }
}

enum VBottom: AlignmentID {
    static func defaultValue(in context: Size) -> Int {
        context.height
    }
}

enum HLeading: AlignmentID {
    static func defaultValue(in context: Size) -> Int { 0 }
}

enum HCenter: AlignmentID {
    static func defaultValue(in context: Size) -> Int { context.width/2 }
}

enum HTrailing: AlignmentID {
    static func defaultValue(in context: Size) -> Int { context.width }
}

extension Alignment {
    func point(for size: Size) -> Point {
        let x = horizontal.alignmentID.defaultValue(in: size)
        let y = vertical.alignmentID.defaultValue(in: size)
        return Point(x: x, y: y)
    }
}

//struct CustomHAlignmentGuide<Content: View>: BuiltinView, BuiltinView {
//    var content: Content
//    var alignment: HorizontalAlignment
//    var computeValue: (Size) -> Width
//
//    var layoutPriority: Double {
//        content._layoutPriority
//    }
//
//    func render(context: RenderingContext, size: Size) {
//        content._render(context: context, size: size)
//    }
//    func size(proposed: ProposedSize) -> Size {
//        content._size(proposed: proposed)
//    }
//    func customAlignment(for alignment: HorizontalAlignment, in size: Size) -> Width? {
//        if alignment.alignmentID == self.alignment.alignmentID {
//            return computeValue(size)
//        }
//        return content._customAlignment(for: alignment, in: size)
//    }
//    var swiftUI: some View {
//        content.swiftUI.alignmentGuide(alignment.swiftUI, computeValue: {
//            computeValue(Size(width: $0.width, height: $0.height))
//        })
//    }
//}
//
//extension BuiltinView {
//    func alignmentGuide(for alignment: HorizontalAlignment, computeValue: @escaping (Size) -> Width) -> some BuiltinView {
//        CustomHAlignmentGuide(content: self, alignment: alignment, computeValue: computeValue)
//    }
//}
