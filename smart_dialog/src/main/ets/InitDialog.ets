import { dialogProxy } from './dialog_proxy/DialogProxy'
import SmartNavigatorObserver from './helper/SmartNavigatorObserver'
import { BackHelper } from './helper/BackHelper'
import { LoadingNode } from './component/loading_dialog/LoadingDialogComponent'

@Component
export struct OhosSmartDialog {
  static observe: SmartNavigatorObserver = new SmartNavigatorObserver()

  static registerRouter(navPathStack: NavPathStack): NavPathStack {
    navPathStack.setInterception(OhosSmartDialog.observe)
    return dialogProxy.navPathStack = navPathStack
  }

  static onBackPressed = BackHelper.instance.onBackPressed

  build() {
    Stack() {
      NodeContainer(dialogProxy.nodeController)

      LoadingNode()
    }
  }
}