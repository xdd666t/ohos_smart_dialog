import { BaseDialogModel } from '../model/BaseDialogModel'
import { onBlockClick, SmartBuilder } from '../kit/function'
import { DialogProxy } from '../helper/DialogProxy'

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
    .animation({ duration: this.item.animation.time, curve: Curve.Linear })
    .width('100%')
    .height('100%')
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Up) {
        this.item.onMask?.()
        if (this.item.clickMaskDismiss) {
          DialogProxy.instance.dismiss()
        }
      }
    })
    .onClick(this.item.usePenetrate ? undefined : () => onBlockClick())
  }
}