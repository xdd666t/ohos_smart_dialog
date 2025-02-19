import { SmartBuilder } from '../../kit/Function'
import { CustomDialogModel } from './CustomDialogModel'

@Component
export struct CustomDialogComponent {
  @BuilderParam builder?: SmartBuilder
  item: CustomDialogModel = new CustomDialogModel()

  aboutToAppear(): void {
    this.builder = this.item.builder
    this.item.initAnimationStatus()
  }

  build() {
    Stack() {
      this.builder?.(this.item.builderArgs)
    }
    .scale({ x: this.item.animation.dialogScaleX, y: this.item.animation.dialogScaleY })
    .opacity(this.item.animation.dialogOpacity)
    .position(this.item.animation.dialogPosition)
    .animation({ duration: this.item.animation.dialogTime, curve: Curve.Linear })
    .gesture(GestureGroup(GestureMode.Exclusive,
      TapGesture(),
      LongPressGesture(),
      PanGesture(),
      PinchGesture(),
      SwipeGesture(),
      RotationGesture(),
    ))
    .onTouch((event: TouchEvent) => event.stopPropagation())
    .onAppear(() => this.item.show())
  }
}