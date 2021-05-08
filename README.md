# terminal-ui

A way to build [TUI](https://en.wikipedia.org/wiki/Text-based_user_interface) apps with a layout system and API that's similar to SwiftUI.

We reimplemented parts of the SwiftUI layout system in the Swift Talk series [SwiftUI Layout Explained](https://talk.objc.io/collections/swiftui-layout-explained). This tries to stay as close to that as possible.

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
  - [ ] Padding (In progress)
  - [ ] Custom Alignment Guides
  - [ ] Layout Priorities  
  - [ ] VStack
  - [ ] List
  - [ ] Button
  - More ideas (lower priority)
    - [ ] Tree View (similar to outlines)
    - [ ] Menus
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
