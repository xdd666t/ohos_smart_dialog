import { AttachDialogModel } from '../model/AttachDialogModel';
import { randomTag, SmartBuilder } from '../kit/function';


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
      .height(this.item.animation.dialogHeight)
      .width(this.item.animation.dialogWidth)
      .scale({ x: this.item.animation.dialogScale, y: this.item.animation.dialogScale })
      .position(this.item.animation.dialogPosition)
      .opacity(this.item.animation.dialogOpacity)
      .animation({ duration: this.item.animationTime, curve: Curve.Linear })
      .onSizeChange(() => {
        if (!this.alreadyStartAnimation) {
          this.alreadyStartAnimation = true
          this.item.startAnimation()
        }
      })
    }
  }
}