public struct TTYRenderingContext: RenderingContext {
    var origin: Point = .zero
    public var foregroundColor: Color? = nil
    public var backgroundColor: Color? = nil
    
    mutating public func translateBy(_ point: Point) {
        origin.x += point.x
        origin.y += point.y
    }
    
    public func write<S: StringProtocol>(_ s: S) {
        setColor(foregroundColor: foregroundColor, backgroundColor: backgroundColor)
        move(to: origin)
        _write(String(s))
    }
}

// Concrete implementations have to have value semantics: it should be possible to make a copy by doing `var c = previousContext` and `c` and `previousContext` should be separate instances. In other words, conforming types need to be a struct.
public protocol RenderingContext {
    var foregroundColor: Color? { get set }
    var backgroundColor: Color? { get set }
    mutating func translateBy(_ point: Point)
    func write<S: StringProtocol>(_ s: S)
}
