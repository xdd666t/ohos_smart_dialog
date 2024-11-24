import { SmartDialog } from "ohos_smart_dialog"
import { randomColor } from "../../app/kit/Color"

export function globalUsePenetrate() {
  SmartDialog.show({
    builder: dialogUsePenetrateConfig,
  })
}

@Builder
function dialogUsePenetrateConfig() {
  Column() {
    Text(`当前usePenetrate全局配置: ${SmartDialog.config.global.usePenetrate}`).fontColor(Color.White)

    Button("切换").fontColor(Color.White).margin({ top: 20 }).onClick(() => {
      SmartDialog.config.global.usePenetrate = !SmartDialog.config.global.usePenetrate
    })
  }
  .padding(30)
  .borderRadius(12)
  .backgroundColor(randomColor())
}