import TerminalUI

var rootView: some BuiltinView {
    HStack(children: [
        Text("Hello")
            .padding()
            .foregroundColor(.blue)
            .border()
            .padding()            
            .backgroundColor(.red),
        Text("Testing A Longer Text")
            .frame(maxWidth: .max)
            .border()
            .padding(),
        ZStack(alignment: .center, children: [
            Text("Test").padding().border(),
            Text("+").backgroundColor(.green)
        ]),
        Text(["This", "is", "a", "truncation", "test"].joined(separator: "\n")) // todo: fix this crash
    ], alignment: .bottom)
    .overlay(Text("[x]", color: .red), alignment: .topTrailing)
    .overlay(GeometryReader(alignment: .bottom) { size in
        Text("\(size.width)⨉\(size.height)")
    })
    .border()
}



run(rootView)
