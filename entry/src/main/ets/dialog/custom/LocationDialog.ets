import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'
import { delay } from '../../app/kit/function'

export async function customLocation() {
  const animationTime = 1000
  SmartDialog.show({
    builder: dialogLocationHorizontal,
    alignment: Alignment.Start,
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogLocationVertical,
    alignment: Alignment.Top,
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogLocationHorizontal,
    alignment: Alignment.End,
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogLocationVertical,
    alignment: Alignment.Bottom,
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogLocationCenter,
    alignment: Alignment.Center,
  })
}


@Builder
function dialogLocationVertical() {
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
function dialogLocationHorizontal() {
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
function dialogLocationCenter() {
  Text("location")
    .width("30%")
    .height("30%")
    .fontSize(20)
    .borderRadius(12)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}
