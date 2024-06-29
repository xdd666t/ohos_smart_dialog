import { AttachDialogModel } from '../model/AttachDialogModel';
import { randomTag, SmartBuilder } from '../kit/function';


@Component
export struct AttachDialogComponent {
  @BuilderParam builder?: SmartBuilder
  item: AttachDialogModel = new AttachDialogModel()
  selfId = randomTag()
  firstRender = true

  aboutToAppear(): void {
    this.builder = this.item.builder
  }

  build() {
    Stack() {
      this.builder?.(this.item.builderArgs)
    }
    .height(this.item.animation.dialogHeight)
    .width(this.item.animation.dialogWidth)
    .scale({ x: this.item.animation.dialogScale, y: this.item.animation.dialogScale })
    .position(this.item.animation.dialogPosition)
    .opacity(this.item.animation.dialogOpacity)
    .onSizeChange(() => {
      if (this.firstRender) {
        this.firstRender = false
        this.item.initAnimationStatus(this.selfId)
      }
    })
    .id(this.selfId)
  }
}