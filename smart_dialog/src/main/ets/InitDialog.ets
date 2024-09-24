import SmartNavigatorObserver from './helper/SmartNavigatorObserver'
import { BackHelper } from './helper/BackHelper'
import { DialogProxy } from './helper/DialogProxy'
import { SmartBuilder } from './kit/function'
import { defaultLoadingBuilder } from './component/default/loading_component'

@Component
export struct OhosSmartDialog {
  // 默认loading样式
  @BuilderParam loadingBuilder?: SmartBuilder
  static observe: SmartNavigatorObserver = new SmartNavigatorObserver()
  static onConfigurationUpdate = DialogProxy.instance.onConfigurationUpdate

  aboutToAppear(): void {
    DialogProxy.instance.loadingBuilder = this.loadingBuilder ?? defaultLoadingBuilder
  }

  static registerRouter(navPathStack: NavPathStack): NavPathStack {
    navPathStack.setInterception(OhosSmartDialog.observe)
    return DialogProxy.instance.navPathStack = navPathStack
  }

  static onBackPressed = BackHelper.instance.onBackPressed

  build() {
    Stack() {
      NodeContainer(DialogProxy.instance.dialogNodeController)

      NodeContainer(DialogProxy.instance.loadingNodeController)
    }.hitTestBehavior(HitTestMode.Default)
  }
}