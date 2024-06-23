import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

@Builder
export function dialogShowDialog() {
  Text("showDialog")
    .fontSize(30)
    .padding(50)
    .fontColor(Color.White)
    .backgroundColor(randomColor())
    .onClick(() => {
      SmartDialog.show({
        builder: wrapBuilder(dialogShowDialog),
      })
    })
}