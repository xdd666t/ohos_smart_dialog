import { SmartDialog } from 'ohos_smart_dialog'
import { PageName, RouterHelper } from './helper/RouterHelper'
import { randomColor } from './kit/Color'

@Builder
export function buildMainPage() {
  MainPage()
}

@Component
struct MainPage {
  build() {
    Stack() {
      Button("MainPage")
        .backgroundColor(Color.Orange)
        .onClick(() => this.showDialog())
    }.width("100%").height("100%")
  }

  showDialog(): void {
    SmartDialog.show({
      wrapBuilder: wrapBuilder(wrapDialogText),
    })
  }
}

@Builder
function wrapDialogText() {
  Text("JumPage")
    .fontSize(30)
    .padding(50)
    .backgroundColor(randomColor())
    .onClick(() => {
      RouterHelper.stack.pushPath(RouterHelper.routeMap.get(PageName.jumpPage)?.navPathInfo)
    })
}


