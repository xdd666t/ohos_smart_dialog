import { AttachDialogModel } from './AttachDialogModel';
import { randomTag, SmartBuilder } from '../../kit/Function';


@Component
export struct AttachDialogComponent {
  @BuilderParam builder?: SmartBuilder
  item: AttachDialogModel = new AttachDialogModel()
  @State firstRender: boolean = true
  alreadyStartAnimation: boolean = false

  aboutToAppear(): void {
    this.builder = this.item.builder
  }

  build() {
    if (this.firstRender) {
      Stack() {
        this.builder?.(this.item.builderArgs)
      }
      .onSizeChange(() => {
        this.item.initAnimationStatus()
        this.firstRender = false
      })
      .visibility(Visibility.Hidden)
      .id(this.item.selfId)
    } else {
      Stack() {
        this.builder?.(this.item.builderArgs)
      }
      .scale({
        x: this.item.animation.dialogScaleX,
        y: this.item.animation.dialogScaleY,
        centerX: this.item.animation.dialogScaleCenterX,
        centerY: this.item.animation.dialogScaleCenterY,
      })
      .position(this.item.animation.dialogPosition)
      .opacity(this.item.animation.dialogOpacity)
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
      .onSizeChange(() => {
        if (!this.alreadyStartAnimation) {
          this.alreadyStartAnimation = true
          this.item.show()
        }
      })
      .id(this.item.selfId)
    }
  }
}