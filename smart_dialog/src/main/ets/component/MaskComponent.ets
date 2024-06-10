import { DialogModel } from '../config/model/DialogModel'
import { SmartDialog } from '../SmartDialog'

@Component
export struct MaskComponent {
  item: DialogModel = new DialogModel()

  build() {
    Stack()
      .opacity(this.item.maskOpacity)
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Black)
      .onClick(() => {
        if (this.item.clickMaskDismiss) {
          SmartDialog.dismiss()
        }
      })
  }
}