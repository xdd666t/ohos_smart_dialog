import { OhosSmartDialog, SmartDialog } from 'ohos_smart_dialog'
import EntryAbility from '../app/EntryAbility'
import { randomColor } from '../kit/Color'

@Builder
export function buildJumPage() {
  JumpPage()
}

@Component
struct JumpPage {
  build() {
    NavDestination() {
      Stack() {
        Button("JumpPage")
          .backgroundColor(Color.Orange)
          .onClick(() => this.showDialog())
      }.width("100%").height("100%").backgroundColor(randomColor())
    }
    .hideTitleBar(true)
    .onBackPressed(() => {
      if (OhosSmartDialog.onBackPressed()) {
        return true
      }
      return false
    })
  }

  showDialog() {
    SmartDialog.show({
      wrapBuilder: wrapBuilder(buildJumPage)
    })
  }
}