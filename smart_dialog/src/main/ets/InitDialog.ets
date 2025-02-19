import { BackHelper } from './helper/BackHelper'
import { DialogProxy } from './helper/DialogProxy'
import { SmartBuilder } from './kit/Function'
import { defaultLoadingBuilder } from './dialog/default/loading_component'
import SmartNavigatorObserver from './helper/SmartNavigatorObserver'
import { SmartDialog } from './SmartDialog'


@Component
export struct OhosSmartDialog {
  // 默认loading样式
  @BuilderParam loadingBuilder?: SmartBuilder
  // 监听暗黑模式切换
  static onConfigurationUpdate = DialogProxy.instance.onConfigurationUpdate
  // 返回事件监听
  static onBackPressed = BackHelper.instance.onBackPressed
  /**
   * @deprecated 无需使用属性兼容路由，内部已使用无感路由注册，该属性后续版本将被被移除
   */
  static observe: SmartNavigatorObserver = new SmartNavigatorObserver()

  /**
   * @deprecated 无需使用方法注册路由，内部已使用无感路由注册，该方法后续版本将被被移除
   */
  static registerRouter(navPathStack: NavPathStack): NavPathStack {
    return navPathStack
  }

  aboutToAppear(): void {
    DialogProxy.instance.loadingBuilder = this.loadingBuilder ?? defaultLoadingBuilder
    DialogProxy.instance.navigatorObserve.registerNavSwitch(this.getUIContext())
  }

  aboutToDisappear(): void {
    DialogProxy.instance.navigatorObserve.unregisterNavSwitch(this.getUIContext())
  }

  build() {
    Stack() {
      NodeContainer(DialogProxy.instance.dialogNodeController)

      NodeContainer(DialogProxy.instance.loadingNodeController)
    }.hitTestBehavior(SmartDialog.config.global.usePenetrate ? HitTestMode.Transparent : HitTestMode.Default)
  }
}