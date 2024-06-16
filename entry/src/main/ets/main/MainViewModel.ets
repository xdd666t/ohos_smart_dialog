import { SmartDialog } from 'ohos_smart_dialog'
import { delay } from 'ohos_smart_dialog/src/main/ets/kit/function'
import { dialogCustomMask } from './dialog/CustomMask'
import { dialogJumpPage } from './dialog/JumpPage'
import { dialogLocationCenter, dialogLocationHorizontal, dialogLocationVertical } from './dialog/LocationDialog'
import { dialogShowDialog } from './dialog/ShowDialog'
import { dialogTagA, dialogTagB, dialogTagC, dialogTagD, dialogTagE } from './dialog/TagDialog'
import { ArgsModel, dialogArgs } from './dialog/UseArgs'
import { MainFeature, MainState } from './MainState'

export class MainViewModel {
  mainState: MainState

  constructor(mainState: MainState) {
    this.mainState = mainState
  }

  showDialog(item: string) {
    if (item === MainFeature.useArgs) {
      this.useArgs()
    } else if (item === MainFeature.location) {
      this.location()
    } else if (item === MainFeature.jumpPage) {
      this.jumpPage()
    } else if (item === MainFeature.customMask) {
      this.customMask()
    } else if (item === MainFeature.tag) {
      this.tag()
    }
  }

  useArgs() {
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogArgs),
      wrapBuilderArgs: { msg: Math.random().toString() } as ArgsModel
    })
  }

  async location() {
    const animationTime = 1000
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogLocationHorizontal),
      alignment: Alignment.Start,
    })
    await delay(animationTime)
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogLocationVertical),
      alignment: Alignment.Top,
    })
    await delay(animationTime)
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogLocationHorizontal),
      alignment: Alignment.End,
    })
    await delay(animationTime)
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogLocationVertical),
      alignment: Alignment.Bottom,
    })
    await delay(animationTime)
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogLocationCenter),
      alignment: Alignment.Center,
    })
  }

  async tag() {
    const animationTime = 1000
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogTagA),
      alignment: Alignment.Start,
      tag: "A",
    })
    await delay(animationTime)
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogTagB),
      alignment: Alignment.Top,
      tag: "B",
    })
    await delay(animationTime)
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogTagC),
      alignment: Alignment.End,
      tag: "C",
    })
    await delay(animationTime)
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogTagD),
      alignment: Alignment.Bottom,
      tag: "D",
    })
    await delay(animationTime)
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogTagE),
      alignment: Alignment.Center,
      tag: "E",
    })
  }

  jumpPage() {
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogJumpPage),
    })
  }

  customMask() {
    SmartDialog.show({
      wrapBuilder: wrapBuilder(dialogShowDialog),
      maskWrapBuild: wrapBuilder(dialogCustomMask),
    })
  }
}