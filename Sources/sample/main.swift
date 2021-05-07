import TerminalUI

//var rootView: some BuiltinView {
//    HStack(children: [
//        Text("Hello").padding().border().padding(),
//        Text("Testing")
//            .frame(maxWidth: .max)
//            .border()
//            .padding()
//    ], alignment: .bottom)
//    .overlay(Text("[x]"), alignment: .topTrailing)
//    .overlay(GeometryReader(alignment: .bottom) { size in
//        Text("\(size.width)⨉\(size.height)")
//    })
//    .border()
//}
//
//

var rootView: some BuiltinView {
    Text("Hello")
}
run(rootView)
