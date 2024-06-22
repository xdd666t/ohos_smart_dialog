import { BaseDialogModel } from '../config/model/BaseDialogModel'
import { DialogProxy } from '../dialog_proxy/DialogProxy'

@Component
export struct MaskComponent {
  item: BaseDialogModel = new BaseDialogModel()

  build() {
    Stack() {
      if (this.item.maskBuilder) {
        this.item.maskBuilder?.builder()
      } else {
        Stack()
          .width('100%')
          .height('100%')
          .backgroundColor(this.item.maskColor)
      }
    }
    .width('100%')
    .height('100%')
    .opacity(this.item.animation.maskOpacity)
    .onClick(() => {
      this.item.onMask?.()
      if (this.item.clickMaskDismiss) {
        DialogProxy.instance.dismiss()
      }
    })
    .onAppear(() => {
      animateTo({ duration: this.item.animationTime, curve: Curve.Linear }, () => {
        this.item.animation.maskOpacity = 1
      })
    })
  }
}