import { OhosSmartDialog, SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../app/kit/Color'
import { dialogShowDialog } from '../dialog/custom/ShowDialog'

@Builder
export function buildJumPage() {
  JumpPage()
}

@Component
struct JumpPage {
  build() {
    NavDestination() {
      Stack() {
        Button("showDialog")
          .backgroundColor(Color.Orange)
          .onClick(() => this.showDialog())
      }.width("100%").height("100%").backgroundColor(randomColor())
    }
    .hideTitleBar(true)
    .onBackPressed(OhosSmartDialog.onBackPressed())
  }

  showDialog() {
    SmartDialog.show({
      builder: dialogShowDialog
    })
  }
}