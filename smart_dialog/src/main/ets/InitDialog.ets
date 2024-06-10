import { DialogProxy } from './dialog_proxy/DialogProxy'
import { DialogModel } from './config/model/DialogModel'
import { DialogProxyState } from './dialog_proxy/DialogProxyState'
import { SmartDialog } from './SmartDialog'
import { MaskComponent } from './component/MaskComponent'
import { MainComponent } from './component/MainComponent'

@Component
export struct OhosSmartDialog {
  state: DialogProxyState = DialogProxy.instance.dialogProxyState

  build() {
    Stack() {
      ForEach(this.state.dialogList, (item: DialogModel, index: number) => {
        MaskComponent({ item: item })

        MainComponent({ item: item })
      })
    }
    .width('100%')
    .height('100%')
    .visibility(this.state.dialogList.length === 0 ? Visibility.None : Visibility.Visible)
  }
}