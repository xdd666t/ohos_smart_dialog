import { DialogModel } from '../config/model/DialogModel'
import { DialogNodeController } from '../helper/DialogNodeController'
import { DialogProxyState } from './DialogProxyState'
import { CustomDialogOption } from '../config/model/CustomDialogConfig'
import { SmartDismissOption } from '../config/option/SmartDismissConfig'

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
        model.isOld = true
      } else {
        model.alignment = item.alignment
        model.controller = item.controller
        model.animationTime = item.animationTime
        model.clickMaskDismiss = item.clickMaskDismiss
        model.tag = item.tag
        model.routerName = item.routerName
        model.maskWrapBuild = item.maskWrapBuild
        model.onMask = item.onMask
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

  async dismiss(option?: SmartDismissOption): Promise<void> {
    const state = this.dialogProxyState
    let dialog = this.findDialog(option?.tag)
    if (!dialog) {
      return
    }

    await dialog.dismiss()
    state.originDialogList = state.originDialogList.filter((item) => item.tag !== dialog?.tag)
    DialogProxy.instance.requestLayout()
  }

  private findDialog(tag?: string): DialogModel | undefined {
    let dialogList = this.dialogProxyState.dialogList
    if (dialogList.length === 0) {
      return
    }

    if (tag) {
      for (let index = 0; index < dialogList.length; index++) {
        let item = dialogList[index]
        if (item.tag === tag) {
          return item
        }
      }
    }

    return dialogList[dialogList.length - 1]
  }
}
