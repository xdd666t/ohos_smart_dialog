import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function customUsePenetrate() {
  SmartDialog.show({
    builder: dialogUsePenetrate,
    usePenetrate: true,
  })
}

@Builder
function dialogUsePenetrate() {
  Text(`点击mask的事件能透传给页面`).fontColor(Color.White).padding(50)
    .borderRadius(12)
    .backgroundColor(randomColor())
}