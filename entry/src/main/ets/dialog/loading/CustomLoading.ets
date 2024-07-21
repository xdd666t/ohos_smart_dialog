import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function loadingCustom() {
  SmartDialog.showLoading({
    builder: customLoading,
    clickMaskDismiss: false,
    onMask: () => {
      SmartDialog.dismiss({ tag: '111' })
    },
    tag: "1"
  })
}

@Builder
export function customLoading() {
  Column({ space: 5 }) {
    Text("Custom Loading").fontSize(16).fontColor(Color.White)
    LoadingProgress().width(80).height(80).color(Color.White)
  }
  .backgroundColor(randomColor())
  .padding(20)
  .borderRadius(12)
  .onClick(() => loadingCustom())
}