import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function attachEasy() {
  SmartDialog.show({
    builder: dialog
  })
}

@Builder
function dialog() {
  Stack() {
    Text("Attach")
      .backgroundColor(randomColor())
      .padding(20)
      .fontColor(Color.White)
      .borderRadius(5)
      .onClick(() => {
        SmartDialog.showAttach({
          targetId: "Attach",
          builder: targetLocationDialog,
        })
      })
      .id("Attach")
  }
  .borderRadius(12)
  .padding(50)
  .backgroundColor(Color.White)
}

@Builder
function targetLocationDialog() {
  Text("targetIdDialog")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .borderRadius(12)
    .backgroundColor(randomColor())
}