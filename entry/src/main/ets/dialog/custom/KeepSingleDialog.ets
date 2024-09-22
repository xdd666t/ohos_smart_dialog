import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'
import { delay } from '../../app/kit/function'

export async function customKeepSingle() {
  const animationTime = 1000
  const keepSingleTag = "Alignment.End"
  SmartDialog.show({
    builder: dialogLocationHorizontal,
    builderArgs: "keepSingle",
    alignment: Alignment.Start,
    // 不设置tag的keepSingle, 将使用默认tag保持keepSingle的弹窗
    keepSingle: true,
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogLocationHorizontal,
    builderArgs: `keepSingle:tag:${keepSingleTag}`,
    alignment: Alignment.End,
    keepSingle: true,
    // 设置tag+keepSingle, 可创建多个同时存在的keepSingle弹窗
    tag: keepSingleTag,
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogLocationVertical,
    builderArgs: "multiple",
    alignment: Alignment.Top,
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogLocationHorizontal,
    builderArgs: "keepSingle",
    alignment: Alignment.Start,
    keepSingle: true,
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogLocationHorizontal,
    builderArgs: `keepSingle:tag:${keepSingleTag}`,
    alignment: Alignment.End,
    keepSingle: true,
    tag: keepSingleTag,
  })
}


@Builder
function dialogLocationVertical(msg: string) {
  Text(msg)
    .width("100%")
    .height("20%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
function dialogLocationHorizontal(msg: string) {
  Text(msg)
    .width("35%")
    .height("100%")
    .fontSize(15)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(10)
    .backgroundColor(randomColor())
}
