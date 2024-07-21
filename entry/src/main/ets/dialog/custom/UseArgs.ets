import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function customUseArgs() {
  SmartDialog.showLoading({ builderArgs: 1 })
  SmartDialog.show({
    builder: dialogArgs,
    builderArgs: { num: Math.random() } as ArgsModel,
  })
}

@Builder
function dialogArgs(args: ArgsModel) {

  Text(args.num.toString())
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .margin(50)
    .borderRadius(12)
    .backgroundColor(randomColor())
}

class ArgsModel {
  num: number = 0
}