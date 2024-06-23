import { AttachDialogModel } from '../config/model/AttachDialogModel';
import { randomTag } from '../kit/function';


@Component
export struct AttachDialogComponent {
  item: AttachDialogModel = new AttachDialogModel()
  selfId = randomTag()
  firstRender = true

  build() {
    Stack() {
      this.item.builder?.builder(this.item.builderArgs)
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