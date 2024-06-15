import { DialogProxy } from './dialog_proxy/DialogProxy'
import { DialogModel } from './config/model/DialogModel'
import { DialogProxyState } from './dialog_proxy/DialogProxyState'
import { MaskComponent } from './component/MaskComponent'
import { MainComponent } from './component/MainComponent'
import SmartNavigatorObserver from './helper/SmartNavigatorObserver'
import { BackHelper } from './helper/BackHelper'

@Component
export struct OhosSmartDialog {
  state: DialogProxyState = DialogProxy.instance.dialogProxyState
  static observe: SmartNavigatorObserver = new SmartNavigatorObserver()

  static registerRouter(navPathStack: NavPathStack): NavPathStack {
    DialogProxy.instance.navPathStack = navPathStack
    navPathStack.setInterception(OhosSmartDialog.observe)
    return navPathStack
  }

  static onBackPressed = BackHelper.instance.onBackPressed

  build() {
    Stack() {
      ForEach(this.state.dialogList, (item: DialogModel, index: number) => {
        Stack() {
          MaskComponent({ item: item })

          MainComponent({ item: item })
        }.visibility(item.visible === true ? Visibility.Visible : Visibility.None)
      })
    }
    .width('100%')
    .height('100%')
    .visibility(this.state.visibleDialog ? Visibility.Visible : Visibility.None)
  }

  onBackPress(): boolean | void {

  }
}