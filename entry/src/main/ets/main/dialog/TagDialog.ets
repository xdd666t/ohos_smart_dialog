import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

@Builder
export function dialogTagA() {
  Text("A")
    .width("20%")
    .height("100%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
export function dialogTagB() {
  Text("B")
    .width("100%")
    .height("20%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
export function dialogTagC() {
  Text("C")
    .width("20%")
    .height("100%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
export function dialogTagD() {
  Text("D")
    .width("100%")
    .height("20%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
export function dialogTagE() {
  Flex({ wrap: FlexWrap.Wrap }) {
    ForEach(["closA", "closeB", "closeC", "closeD", "closeSelf"], (item: string, index: number) => {
      Button(item)
        .backgroundColor(Color.Orange)
        .margin(10)
        .onClick(() => {
          if (index === 0) {
            SmartDialog.dismiss({ tag: "A" })
          } else if (index === 1) {
            SmartDialog.dismiss({ tag: "B" })
          } else if (index === 2) {
            SmartDialog.dismiss({ tag: "C" })
          } else if (index === 3) {
            SmartDialog.dismiss({ tag: "D" })
          } else if (index === 4) {
            SmartDialog.dismiss({ tag: "E" })
          }
        })
    })
  }.backgroundColor(Color.Blue).margin({ left: 30, right: 30 })
}
