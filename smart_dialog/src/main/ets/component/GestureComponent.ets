@Component
export struct GestureComponent {
  usePenetrate: boolean = false
  @BuilderParam builder?: VoidCallback

  build() {
    if (this.usePenetrate) {
      this.builder?.()
    } else {
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
    }
  }
}
