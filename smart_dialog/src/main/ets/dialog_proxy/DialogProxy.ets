import { DialogModel } from '../config/model/DialogModel'
import { DialogNodeController } from '../helper/DialogNodeController'
import { DialogProxyState } from './DialogProxyState'
import { SmartCustomDialogOption } from '../config/option/SmartCustomDialogConfig'
import { delay, randomTag } from '../kit/function'

export class DialogProxy {
  private static _instance?: DialogProxy

  private constructor() {
  }

  static get instance() {
    if (!DialogProxy._instance) {
      DialogProxy._instance = new DialogProxy()
    }
    return DialogProxy._instance
  }

  dialogProxyState: DialogProxyState = new DialogProxyState()

  show(option: SmartCustomDialogOption) {
    this.dialogProxyState.optionDialogList.push(option)
    DialogProxy.instance.requestLayout()
  }

  requestLayout() {
    this.dialogProxyState.dialogList.forEach((item) => {
      item.dialogNode?.rootNode?.dispose()
      item.controller?.removeListener()
    })

    let list: Array<DialogModel> = []
    this.dialogProxyState.optionDialogList.forEach((item) => {
      let oldModel = this.dialogProxyState.dialogList.find((oldItem) => oldItem.tag === item.tag)
      let model: DialogModel = new DialogModel()
      if (oldModel) {
        model = oldModel
      } else {
        model.controller = item.controller
        model.animationTime = item.animationTime
        model.clickMaskDismiss = item.clickMaskDismiss
        model.tag = item.tag
      }
      model.dialogNode = new DialogNodeController(item.wrapBuilder, item.wrapBuilderArgs, item.controller)
      list.push(model)
    })
    this.dialogProxyState.dialogList = list
  }

  async dismiss(): Promise<void> {
    let dialogList = this.dialogProxyState.dialogList
    if (dialogList.length === 0) {
      return
    }
    let lastDialog = dialogList[dialogList.length - 1]
    animateTo({
      duration: lastDialog.animationTime,
      curve: Curve.Linear,
    }, () => {
      lastDialog.maskOpacity = 0
      lastDialog.mainScale = 0
    })
    await delay(lastDialog.animationTime)

    this.dialogProxyState.optionDialogList.pop()
    DialogProxy.instance.requestLayout()
  }
}
