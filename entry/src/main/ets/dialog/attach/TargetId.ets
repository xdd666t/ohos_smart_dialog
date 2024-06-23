import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function attachLocation(targetId: string) {
  SmartDialog.showAttach({
    targetId: targetId,
    builder: wrapBuilder(targetIdDialog)
  })
}

@Builder
function targetIdDialog() {
  Text("targetIdDialog")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .borderRadius(12)
    .backgroundColor(randomColor())
}