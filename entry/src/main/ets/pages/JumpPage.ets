import { SmartDialog } from 'ohos_smart_dialog'
import { RouterHelper } from '../app/helper/RouterHelper'
import { randomColor } from '../app/kit/Color'
import { customJumpPage } from '../dialog/custom/JumpPage'

@Builder
export function buildJumPage() {
  JumpPage()
}

@Component
struct JumpPage {
  build() {
    NavDestination() {
      Stack() {
        Row({ space: 30 }) {
          Button("showDialog")
            .backgroundColor(Color.Orange)
            .onClick(() => customJumpPage())
          Button("backHome")
            .backgroundColor(Color.Orange)
            .onClick(() => this.backHome())
          Button("forceDismiss")
            .backgroundColor(Color.Orange)
            .onClick(() => SmartDialog.dismiss({ force: true }))
        }
      }.width("100%").height("100%").backgroundColor(randomColor())
    }
    .hideTitleBar(true)
    .onBackPressed(SmartDialog.onBackPressed())
  }

  private backHome() {
    RouterHelper.stack.clear()
  }
}