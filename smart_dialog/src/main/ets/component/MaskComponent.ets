import { BaseDialogModel } from '../model/BaseDialogModel'
import { DialogProxy } from '../dialog_proxy/DialogProxy'
import { SmartBuilder } from '../kit/function'

@Component
export struct MaskComponent {
  @BuilderParam maskBuilder?: SmartBuilder
  item: BaseDialogModel = new BaseDialogModel()

  aboutToAppear(): void {
    this.maskBuilder = this.item.maskBuilder
  }

  build() {
    Stack() {
      if (this.maskBuilder) {
        this.maskBuilder()
      } else {
        Stack().width('100%').height('100%').backgroundColor(this.item.maskColor)
      }
    }
    .opacity(this.item.animation.maskOpacity)
    .animation({ duration: this.item.animationTime, curve: Curve.Linear })
    .width('100%')
    .height('100%')
    .onClick(() => {
      this.item.onMask?.()
      if (this.item.clickMaskDismiss) {
        DialogProxy.instance.dismiss()
      }
    })
  }
}