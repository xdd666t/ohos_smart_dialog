import { randomColor } from '../../app/kit/Color'

@Builder
export function dialogArgs(args: ArgsModel) {
  Text(args.msg)
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .margin(50)
    .backgroundColor(randomColor())
}

export class ArgsModel {
  msg: string = ""
}