import { DialogModel } from '../config/model/DialogModel'
import { SmartDialog } from '../SmartDialog'

@Component
export struct MaskComponent {
  item: DialogModel = new DialogModel()

  build() {
    Stack() {
      if (this.item.maskWrapBuild) {
        this.item.maskWrapBuild?.builder()
      } else {
        Stack()
          .width('100%')
          .height('100%')
          .backgroundColor(Color.Black)
          .opacity(0.46)
      }
    }
    .width('100%')
    .height('100%')
    .opacity(this.item.animation.maskOpacity)
    .onClick(() => {
      this.item.onMask?.()
      if (this.item.clickMaskDismiss) {
        SmartDialog.dismiss()
      }
    })
    .onAppear(() => {
      animateTo({ duration: this.item.animationTime, curve: Curve.Linear }, () => {
        this.item.animation.maskOpacity = 1
      })
    })
  }
}