import TerminalUI

struct Sample: View {
    var body: some View {
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
}

func rootView(_ char: Int32?) -> some View {
    var alignment: HorizontalAlignment = .center
    if char == 108 { alignment = .leading }
    if char == 114 { alignment = .trailing }
    return VStack(alignment: alignment, children: [
        Text("Hello"),
        Text("\(char ?? 0)"),
        Text("Sunny World")
            .border(style: .ascii)
        
    ]).padding()
    .border()
}


run({ _ in Sample() })
