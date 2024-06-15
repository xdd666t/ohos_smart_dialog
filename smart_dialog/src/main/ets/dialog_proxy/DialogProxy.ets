import { DialogModel } from '../config/model/DialogModel'
import { DialogNodeController } from '../helper/DialogNodeController'
import { DialogProxyState } from './DialogProxyState'
import { delay } from '../kit/function'
import { CustomDialogOption } from '../config/model/CustomDialogConfig'

export class DialogProxy {
  private static _instance?: DialogProxy

  private constructor() {
  }

  static get instance() {
    return DialogProxy._instance ? DialogProxy._instance : DialogProxy._instance = new DialogProxy()
  }

  dialogProxyState: DialogProxyState = new DialogProxyState()
  navPathStack: NavPathStack = new NavPathStack()

  show(option: CustomDialogOption) {
    this.dialogProxyState.originDialogList.push(option)
    DialogProxy.instance.requestLayout()
  }

  requestLayout() {
    this.dialogProxyState.dialogList.forEach((item) => {
      item.dialogNode?.rootNode?.dispose()
      item.controller?.removeListener()
    })

    let list: Array<DialogModel> = []
    this.dialogProxyState.originDialogList.forEach((item) => {
      let oldModel = this.dialogProxyState.dialogList.find((oldItem) => oldItem.tag === item.tag)
      let model: DialogModel = new DialogModel()
      if (oldModel) {
        model = oldModel
      } else {
        model.controller = item.controller
        model.animationTime = item.animationTime
        model.clickMaskDismiss = item.clickMaskDismiss
        model.tag = item.tag
        model.routerName = item.routerName
      }
      model.dialogNode = new DialogNodeController(item.wrapBuilder, item.wrapBuilderArgs, item.controller)
      list.push(model)
    })
    this.dialogProxyState.dialogList = list

    let visibleDialog = false
    list.forEach((item) => {
      if (item.visible) {
        visibleDialog = true
      }
    })
    this.dialogProxyState.visibleDialog = visibleDialog
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

    this.dialogProxyState.originDialogList.pop()
    DialogProxy.instance.requestLayout()
  }
}
