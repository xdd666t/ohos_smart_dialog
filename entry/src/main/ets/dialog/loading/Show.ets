import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function loadingShow() {
  SmartDialog.showLoading({
    builder: dialogShowDialog
  })
}

@Builder
export function dialogShowDialog() {
  Text("showDialog")
    .fontSize(30)
    .padding(50)
    .fontColor(Color.White)
    .backgroundColor(randomColor())
    .onClick(() => loadingShow())
}