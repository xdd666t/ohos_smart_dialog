import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function demoUseArgs() {
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogArgs),
    wrapBuilderArgs: { msg: Math.random().toString() } as ArgsModel
  })
}

@Builder
function dialogArgs(args: ArgsModel) {
  Text(args.msg)
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .margin(50)
    .backgroundColor(randomColor())
}

class ArgsModel {
  msg: string = ""
}