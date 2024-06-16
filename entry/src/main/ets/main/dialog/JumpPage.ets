import { PageName, RouterHelper } from '../../app/helper/RouterHelper'
import { randomColor } from '../../app/kit/Color'

@Builder
export function dialogJumpPage() {
  Text("JumPage")
    .fontSize(30)
    .padding(50)
    .backgroundColor(randomColor())
    .onClick(() => {
      RouterHelper.stack.pushPath(RouterHelper.navPathInfo(PageName.jumpPage))
    })
}

