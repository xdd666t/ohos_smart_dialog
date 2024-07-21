import SmartNavigatorObserver from './helper/SmartNavigatorObserver'
import { BackHelper } from './helper/BackHelper'
import { DialogProxy } from './helper/DialogProxy'

@Component
export struct OhosSmartDialog {
  static observe: SmartNavigatorObserver = new SmartNavigatorObserver()

  static registerRouter(navPathStack: NavPathStack): NavPathStack {
    navPathStack.setInterception(OhosSmartDialog.observe)
    return DialogProxy.instance.navPathStack = navPathStack
  }

  static onBackPressed = BackHelper.instance.onBackPressed

  build() {
    Stack() {
      NodeContainer(DialogProxy.instance.dialogNodeController)

      NodeContainer(DialogProxy.instance.loadingNodeController)
    }
  }
}