import { SmartDialog } from 'ohos_smart_dialog'
import { PageName, RouterHelper } from '../../app/helper/RouterHelper'
import { randomColor } from '../../app/kit/Color'

export function demoJumpPage() {
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogJumpPage),
  })
}

@Builder
function dialogJumpPage() {
  Text("JumPage")
    .fontSize(30)
    .padding(50)
    .backgroundColor(randomColor())
    .onClick(() => {
      RouterHelper.stack.pushPath(RouterHelper.navPathInfo(PageName.jumpPage))
    })
}

