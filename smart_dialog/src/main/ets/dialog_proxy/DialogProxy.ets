import { DialogNodeController } from '../component/DialogNodeController'
import { SmartDismissOption } from '../model/option/SmartDismissOption'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { CustomDialogModel } from '../component/custom_dialog/CustomDialogModel'
import { SmartCustomOption } from '../model/option/SmartCustomOption'
import SmartNavigatorObserver from '../helper/SmartNavigatorObserver'
import { SmartAttachOption } from '../model/option/SmartAttachOption'
import { AttachDialogModel } from '../component/attach_dialog/AttachDialogModel'
import { SmartLoadingOption } from '../model/option/SmartLoadingOption'
import { LoadingDialogModel } from '../component/loading_dialog/LoadingDialogModel'
import { SmartDialog } from '../SmartDialog'
import { SmartAllDialogType } from '../config/EnumConfig'

export class DialogProxy {
  private static _instance?: DialogProxy

  private constructor() {
  }

  static get instance() {
    return DialogProxy._instance ? DialogProxy._instance : DialogProxy._instance = new DialogProxy()
  }

  dialogList: Array<BaseDialogModel> = []
  navPathStack: NavPathStack = new NavPathStack()
  nodeController: DialogNodeController = new DialogNodeController()
  loadingDialog: LoadingDialogModel = new LoadingDialogModel()

  show(option: SmartCustomOption) {
    let model = new CustomDialogModel()
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animationTime = option.animationTime
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.router = SmartNavigatorObserver.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    model.dialogType = SmartAllDialogType.custom
    model.backType = option.backType
    this.nodeController.inset(model)
    this.dialogList.push(model)
  }

  showAttach(option: SmartAttachOption) {
    let model = new AttachDialogModel()
    model.targetId = option.targetId
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animationTime = option.animationTime
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.router = SmartNavigatorObserver.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    model.dialogType = SmartAllDialogType.attach
    model.backType = option.backType
    this.nodeController.inset(model)
    this.dialogList.push(model)
  }

  showLoading(option: SmartLoadingOption) {
    let model = this.loadingDialog
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animationTime = option.animationTime
    model.clickMaskDismiss = option.clickMaskDismiss
    model.router = SmartNavigatorObserver.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    model.dialogType = SmartAllDialogType.loading
    model.backType = option.backType
    model.visible = true
  }

  async dismiss(option?: SmartDismissOption): Promise<void> {
    if (SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })) {
      await this.loadingDialog.dismiss()
      return
    }

    let dialog = this.findDialog(option?.tag)
    if (!dialog) {
      if (this.dialogList.length === 0 && this.nodeController.rootNode?.getFirstChild()?.getFirstChild()) {
        this.nodeController.rootNode?.clearChildren()
      }
      return
    }

    await dialog.dismiss()
    this.dialogList = this.dialogList.filter((item) => item.tag !== dialog?.tag)
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

export const dialogProxy = DialogProxy.instance