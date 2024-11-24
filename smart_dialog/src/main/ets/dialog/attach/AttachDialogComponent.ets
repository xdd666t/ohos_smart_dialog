import { AttachDialogModel } from './AttachDialogModel';
import { onBlockClick, randomTag, SmartBuilder } from '../../kit/function';


@Component
export struct AttachDialogComponent {
  @BuilderParam builder?: SmartBuilder
  item: AttachDialogModel = new AttachDialogModel()
  selfId = randomTag()
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
        this.item.initAnimationStatus(this.selfId)
        this.firstRender = false
      })
      .visibility(Visibility.Hidden)
      .id(this.selfId)
    } else {
      Stack() {
        this.builder?.(this.item.builderArgs)
      }
      .scale({ x: this.item.animation.dialogScaleX, y: this.item.animation.dialogScaleY })
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
      .onSizeChange(() => {
        if (!this.alreadyStartAnimation) {
          this.alreadyStartAnimation = true
          this.item.show()
        }
      })
      .onClick(() => onBlockClick())
    }
  }
}