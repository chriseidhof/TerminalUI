public struct RenderingContext {
    var origin: Point = .zero
    var foregroundColor: Color? = nil
    var backgroundColor: Color? = nil
    
    mutating func translateBy(_ point: Point) {
        origin.x += point.x
        origin.y += point.y
    }
    
    func write<S: StringProtocol>(_ s: S) {
        setColor(foregroundColor: foregroundColor, backgroundColor: backgroundColor)
        move(to: origin)
        _write(String(s))
    }
}
