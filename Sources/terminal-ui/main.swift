import Darwin

func winsz_handler(sig: Int32) {
    render()
}


func enableRawMode(file: Int32) -> termios {
    var raw: termios = .init()
    tcgetattr(file, &raw)
    let original = raw
    raw.c_lflag &= ~(UInt(ECHO | ICANON))
    tcsetattr(file, TCSAFLUSH, &raw);
    return original
}


var rootView: some BuiltinView {
    Text("Hello")
        .padding()
        .border(style: .ascii)
        .frame(maxWidth: .max, maxHeight: .max)
        .border()
        .padding(3)
}

struct RenderingContext {
    var origin: Point = .zero
    
    mutating func translateBy(_ point: Point) {
        origin.x += point.x
        origin.y += point.y
    }
    
    func write<S: StringProtocol>(_ s: S) {
        move(to: origin)
        _write(String(s))
    }
}

func render() {
    var w: winsize = .init()
    _ = ioctl(STDOUT_FILENO, TIOCGWINSZ, &w)
    let size: Size = Size(width: Int(w.ws_col), height: Int(w.ws_row))
    clearScreen()
    move(to: Point(x: 1, y: 1))
    let implicit = rootView
        .frame(width: size.width, height: size.height, alignment: .trailing)
    let s = implicit.size(for: ProposedSize(size))
    implicit.render(context: RenderingContext(), size: s)
    
}

struct Point {
    var x: Int
    var y: Int
    
    static let zero = Point(x: 0, y: 0)
}

func clearScreen() {
    _write("\u{1b}[2J")
}

func move(to: Point) {
    _write("\u{1b}[\(to.y+1);\(to.x+1)H")
}

fileprivate func _write(_ str: String, fd: Int32 = STDOUT_FILENO) {
    _ = str.withCString { str in
        write(fd, str, strlen(str))
    }
    
}

func main() {
    _ = enableRawMode(file: STDOUT_FILENO)
    render()
    signal(SIGWINCH, winsz_handler)
    _ = enableRawMode(file: STDIN_FILENO)
    var c = getchar()
    while true {
        print(c)
        c = getchar()
    }
}

main()

