import { DialogNodeController } from '../node_controller/DialogNodeController'
import { SmartDismissOption } from '../model/option/SmartDismissOption'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { CustomDialogModel } from '../component/custom_dialog/CustomDialogModel'
import { SmartCustomOption } from '../model/option/SmartCustomOption'
import SmartNavigatorObserver from './SmartNavigatorObserver'
import { SmartAttachOption } from '../model/option/SmartAttachOption'
import { AttachDialogModel } from '../component/attach_dialog/AttachDialogModel'
import { SmartLoadingOption } from '../model/option/SmartLoadingOption'
import { LoadingDialogModel } from '../component/loading_dialog/LoadingDialogModel'
import { SmartDialog } from '../SmartDialog'
import { SmartAllDialogType } from '../config/EnumConfig'
import { LoadingNodeController } from '../node_controller/LoadingNodeController'
import { SmartBuilder } from '../kit/function'

export class DialogProxy {
  private static _instance?: DialogProxy

  private constructor() {
  }

  static get instance() {
    return DialogProxy._instance ? DialogProxy._instance : DialogProxy._instance = new DialogProxy()
  }

  dialogList: Array<BaseDialogModel> = []
  loadingDialog?: LoadingDialogModel
  navPathStack: NavPathStack = new NavPathStack()
  dialogNodeController: DialogNodeController = new DialogNodeController()
  loadingNodeController: LoadingNodeController = new LoadingNodeController()
  // default style
  loadingBuilder?: SmartBuilder

  show(option: SmartCustomOption) {
    let model = new CustomDialogModel()
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animation.startTime = option.animationTime
    model.animation.endTime = option.animationTime
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.router = SmartNavigatorObserver.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    model.dialogType = SmartAllDialogType.custom
    model.backType = option.backType
    this.dialogNodeController.inset(model)
    this.dialogList.push(model)
  }

  showAttach(option: SmartAttachOption) {
    let model = new AttachDialogModel()
    model.targetId = option.targetId
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animation.startTime = option.animationTime
    model.animation.endTime = option.animationTime
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.router = SmartNavigatorObserver.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    model.dialogType = SmartAllDialogType.attach
    model.backType = option.backType
    this.dialogNodeController.inset(model)
    this.dialogList.push(model)
  }

  showLoading(option: SmartLoadingOption) {
    let model = this.loadingDialog = new LoadingDialogModel()
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animation.startTime = option.animationTime
    model.animation.endTime = option.animationTime
    model.clickMaskDismiss = option.clickMaskDismiss
    model.router = SmartNavigatorObserver.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    model.dialogType = SmartAllDialogType.loading
    model.backType = option.backType

    this.loadingNodeController.update(model)
  }

  async dismiss(option?: SmartDismissOption): Promise<void> {
    if (SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })) {
      await this.loadingDialog?.dismiss()
      return
    }

    const dialogList = this.dialogList
    let dialog = this.findDialog(option?.tag)
    if (!dialog) {
      const rootNode = this.dialogNodeController.rootNode
      if (dialogList.length === 0 && rootNode?.getFirstChild()) {
        rootNode?.clearChildren()
      }
      return
    }

    await dialog.dismiss()
    this.dialogList = dialogList.filter((item) => item.tag !== dialog?.tag)
  }

  findDialog(tag?: string): BaseDialogModel | undefined {
    let dialogList = this.dialogList
    if (dialogList.length === 0) {
      return undefined
    }

    if (tag) {
      let dialogInfo: BaseDialogModel | undefined = undefined
      for (let index = dialogList.length - 1; index >= 0; index--) {
        let item = dialogList[index]
        if (item.tag === tag) {
          dialogInfo = item
          break;
        }
      }
      return dialogInfo?.visible ? dialogInfo : undefined
    }

    for (let i = dialogList.length - 1; i >= 0; i--) {
      let item = dialogList[i]
      if (item.visible) {
        return item
      }
    }

    return undefined
  }
}