import { randomColor } from '../../app/kit/Color'

@Builder
export function dialogLocationVertical() {
  Text("location")
    .width("100%")
    .height("20%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
export function dialogLocationHorizontal() {
  Text("location")
    .width("30%")
    .height("100%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
export function dialogLocationCenter() {
  Text("location")
    .width("30%")
    .height("30%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}
