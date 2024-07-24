import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function loadingCustom() {
  SmartDialog.showLoading({
    builder: customLoading,
  })
}

@Builder
export function customLoading() {
  Column({ space: 5 }) {
    Text("again open loading").fontSize(16).fontColor(Color.White)
    LoadingProgress().width(80).height(80).color(Color.White)
  }
  .padding(20)
  .borderRadius(12)
  .onClick(() => loadingCustom())
  .backgroundColor(randomColor())
  // .backgroundColor($r("app.color.bg_theme_color"))
}