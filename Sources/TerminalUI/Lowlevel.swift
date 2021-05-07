//
//  File.swift
//  
//
//  Created by Chris Eidhof on 06.05.21.
//

import Darwin

// Taken from https://stackoverflow.com/questions/49748507/listening-to-stdin-in-swift
func enableRawMode(file: Int32) -> termios {
    var raw: termios = .init()
    tcgetattr(file, &raw)
    let original = raw
    raw.c_lflag &= ~(UInt(ECHO | ICANON))
    tcsetattr(file, TCSAFLUSH, &raw);
    return original
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

func winsz_handler(sig: Int32) {
    render()
}

var current: BuiltinView? = nil

func render() {
    var w: winsize = .init()
    _ = ioctl(STDOUT_FILENO, TIOCGWINSZ, &w)
    let size: Size = Size(width: Int(w.ws_col), height: Int(w.ws_row))
    clearScreen()
    move(to: Point(x: 1, y: 1))
    let implicit = current!
    let s = implicit.size(for: ProposedSize(size))
    implicit.render(context: RenderingContext(), size: s)
    
}

public func run<V: BuiltinView>(_ rootView: V) {
    current = rootView.frame(maxWidth: .max, maxHeight: .max)
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
