@Component
export struct GestureComponent {
  useDefaultGesture: boolean = false
  @BuilderParam builder?: VoidCallback

  build() {
    if (this.useDefaultGesture) {
      Stack() {
        this.builder?.()
      }
      .gesture(GestureGroup(GestureMode.Exclusive,
        TapGesture(),
        LongPressGesture(),
        PanGesture(),
        PinchGesture(),
        SwipeGesture(),
        RotationGesture(),
      ))
      .onTouch((event: TouchEvent) => event.stopPropagation())
    } else {
      this.builder?.()
    }
  }
}
