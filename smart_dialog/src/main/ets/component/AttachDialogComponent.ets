import { AttachDialogModel } from '../config/model/AttachDialogModel';
import { randomTag } from '../kit/function';


@Component
export struct AttachDialogComponent {
  item: AttachDialogModel = new AttachDialogModel()
  selfId = randomTag()

  build() {
    Stack() {
      this.item.builder?.builder(this.item.builderArgs)
    }
    .scale({ x: this.item.animation.dialogScale, y: this.item.animation.dialogScale })
    .position(this.item.animation.dialogPosition)
    .opacity(this.item.animation.dialogOpacity)
    .onAppear(() => {
      this.item.initAnimationStatus(this.selfId)
      this.item.startAnimation()
    })
    .id(this.selfId)
  }
}