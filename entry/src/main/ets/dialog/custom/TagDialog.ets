import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'
import { delay } from '../../app/kit/function'

export async function customTag() {
  const animationTime = 1000
  SmartDialog.show({
    builder: dialogTagA,
    alignment: Alignment.Start,
    tag: "A",
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogTagB,
    alignment: Alignment.Top,
    tag: "B",
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogTagC,
    alignment: Alignment.End,
    tag: "C",
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogTagD,
    alignment: Alignment.Bottom,
    tag: "D",
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogTagE,
    alignment: Alignment.Center,
    tag: "E",
  })
}

@Builder
function dialogTagA() {
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
function dialogTagB() {
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
function dialogTagC() {
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
function dialogTagD() {
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
function dialogTagE() {
  Flex({ wrap: FlexWrap.Wrap }) {
    ForEach(["closA", "closeB", "closeC", "closeD", "closeSelf"], (item: string, index: number) => {
      Button(item)
        .backgroundColor("#4169E1")
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
  }.backgroundColor(Color.White).width(350).margin({ left: 30, right: 30 }).padding(10).borderRadius(10)
}
