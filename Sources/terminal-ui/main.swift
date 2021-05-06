import Darwin

func winsz_handler(sig: Int32) {
    render()
}

struct Size {
    var width: Int
    var height: Int
    
    static let zero = Size(width: 0, height: 0)
}

func enableRawMode(file: Int32) -> termios {
    var raw: termios = .init()
    tcgetattr(file, &raw)
    let original = raw
    raw.c_lflag &= ~(UInt(ECHO | ICANON))
    tcsetattr(file, TCSAFLUSH, &raw);
    return original
}


var rootView: some Builtin {
    Text("Hello")
        .padding()
        .border()
        .padding()
        .border()
}

func render() {
    var w: winsize = .init()
    _ = ioctl(STDOUT_FILENO, TIOCGWINSZ, &w)
    let size: Size = Size(width: Int(w.ws_col), height: Int(w.ws_row))
    clearScreen()
    move(to: Point(x: 1, y: 1))
    let implicit = rootView.frame(width: size.width, height: size.height)
    let s = implicit.size(for: size)
    implicit.render(origin: .zero, size: s)
//    print(s)
    
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

func _write(_ str: String, fd: Int32 = STDOUT_FILENO) {
    _ = str.withCString { str in
        write(fd, str, strlen(str))
    }
    
}

func main() {
    let previous = enableRawMode(file: STDOUT_FILENO)
    render()
    signal(SIGWINCH, winsz_handler)
    let previousStdIn = enableRawMode(file: STDIN_FILENO)
    var c = getchar()
    while true {
        print(c)
        c = getchar()
    }
    print("Done")
}

main()

