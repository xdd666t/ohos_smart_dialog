import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'


export function customMask() {
  SmartDialog.show({
    builder: wrapBuilder(dialogShowDialog),
    maskBuilder: wrapBuilder(dialogCustomMask),
  })
}

@Builder
function dialogCustomMask() {
  Stack().width("100%").height("100%").backgroundColor(randomColor()).opacity(0.6)
}

@Builder
function dialogShowDialog() {
  Text("showDialog")
    .fontSize(30)
    .padding(50)
    .fontColor(Color.White)
    .borderRadius(12)
    .backgroundColor(randomColor())
    .onClick(() => customMask())
}

