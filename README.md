# terminal-ui

A way to build [TUI](https://en.wikipedia.org/wiki/Text-based_user_interface) apps with a layout system and API that's similar to SwiftUI.

We reimplemented parts of the SwiftUI layout system in the Swift Talk series [SwiftUI Layout Explained](https://talk.objc.io/collections/swiftui-layout-explained). This tries to stay as close to that as possible.

A specific goal is to keep the layout behavior as close to SwiftUI as possible. So most SwiftUI programs should "just work" here as well.

Implementation Status

- Views (in random order)
  - [x] Alignment
  - [x] GeometryReader
  - [x] Border
  - [x] Color (so far we only support 16 colors)
  - [x] FixedFrame
  - [x] FlexibleFrame
  - [x] HStack
  - [x] Overlay
  - [x] Background
  - [x] ZStack
  - [x] Text
  - [x] Padding (In progress)
    - [ ] Add tests
  - [ ] Progress
  - [ ] VStack
  - [ ] ScrollView
  - [ ] List
  - [ ] Button
  - [ ] Switch
  - [ ] Custom Alignment Guides
  - [ ] Layout Priorities  
  - More ideas (lower priority)
    - [ ] Tree View (similar to outlines)
    - [ ] Menus
    - [ ] Navigation? (Not sure if this is a good idea, but could be fun to try)
- State/Lifecycle/Interactivity
  - [ ] Custom `View` structures (I think we can build this on top of `BuiltinView`)
  - [ ] Environment (should be easy)
  - [ ] Preferences
  - [ ] State/Binding/ObservedObject
  - [ ] Focus (we should have some way for a control to be in focus, and )
  - [ ] Interaction (nothing is interactive yet)
  - [ ] Animations
  - [ ] ...

Similar Projects:

- https://github.com/migueldeicaza/TermKit
- https://github.com/migueldeicaza/gui.cs

Inspiration:

- https://github.com/aristocratos/bashtop
- https://github.com/rothgar/awesome-tuis
- ...
