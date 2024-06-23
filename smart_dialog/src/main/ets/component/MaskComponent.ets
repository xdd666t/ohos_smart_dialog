import { BaseDialogModel } from '../model/BaseDialogModel'
import { DialogProxy } from '../dialog_proxy/DialogProxy'

@Component
export struct MaskComponent {
  item: BaseDialogModel = new BaseDialogModel()

  build() {
    Stack() {
      if (this.item.maskBuilder) {
        this.item.maskBuilder?.builder()
      } else {
        Stack().width('100%').height('100%').backgroundColor(this.item.maskColor)
      }
    }
    .clip(true)
    .width('100%')
    .height('100%')
    .opacity(this.item.animation.maskOpacity)
    .onClick(() => {
      this.item.onMask?.()
      if (this.item.clickMaskDismiss) {
        DialogProxy.instance.dismiss()
      }
    })
  }
}