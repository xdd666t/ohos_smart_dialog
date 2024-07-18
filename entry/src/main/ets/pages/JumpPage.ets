import { OhosSmartDialog } from 'ohos_smart_dialog'
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
        Button("showDialog")
          .backgroundColor(Color.Orange)
          .onClick(() => customJumpPage())
      }.width("100%").height("100%").backgroundColor(randomColor())
    }
    .hideTitleBar(true)
    .onBackPressed(OhosSmartDialog.onBackPressed())
  }
}