import SmartNavigatorObserver from './helper/SmartNavigatorObserver'
import { BackHelper } from './helper/BackHelper'
import { DialogProxy } from './helper/DialogProxy'
import { SmartBuilder } from './kit/function'
import { defaultLoadingBuilder } from './component/default/loading_component'
import { DialogNavigatorObserver } from './helper/DialogNavigatorObserver'
import { uiObserver } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'

const TAG = "OhosSmartDialog"
@Component
export struct OhosSmartDialog {
  // 默认loading样式
  @BuilderParam loadingBuilder?: SmartBuilder
  static observe: DialogNavigatorObserver = new DialogNavigatorObserver()
  static onConfigurationUpdate = DialogProxy.instance.onConfigurationUpdate

  aboutToAppear(): void {
    DialogProxy.instance.loadingBuilder = this.loadingBuilder ?? defaultLoadingBuilder
    this.registerNavSwitch()
  }

  aboutToDisappear(): void {
    this.unregisterNavSwitch()
  }

  registerNavSwitch() {
    //这里监听Navigation的路由切换
    uiObserver.on('navDestinationSwitch', this.getUIContext(), (info: uiObserver.NavDestinationSwitchInfo) => {
      switch (info.operation) {
        case NavigationOperation.PUSH:
          OhosSmartDialog.observe.onPush(info.from, info.to)
          break;
        case NavigationOperation.POP:
          OhosSmartDialog.observe.onPop(info.from, info.to)
          break;
        case NavigationOperation.REPLACE:
          OhosSmartDialog.observe.onReplace(info.from, info.to)
          break;
      }
    })
  }

  unregisterNavSwitch(){
    uiObserver.off('navDestinationSwitch',this.getUIContext())
  }

  static onBackPressed = BackHelper.instance.onBackPressed

  build() {
    Stack() {
      NodeContainer(DialogProxy.instance.dialogNodeController)

      NodeContainer(DialogProxy.instance.loadingNodeController)
    }.hitTestBehavior(HitTestMode.Transparent)
  }
}