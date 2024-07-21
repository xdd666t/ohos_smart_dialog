import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function customUseArgs() {
  SmartDialog.show({
    builder: dialogArgs,
    // 支持任何类型
    builderArgs: Math.random(),
  })
}

@Builder
function dialogArgs(args: number) {
  Text(`${args}`).fontColor(Color.White).padding(50)
    .borderRadius(12).backgroundColor(randomColor())
}