import { DialogNodeController } from '../component/DialogNodeController'
import { SmartDismissOption } from '../config/option/SmartDismissOption'
import { BaseDialogModel } from '../config/model/BaseDialogModel'
import { CustomDialogModel } from '../config/model/CustomDialogModel'
import { SmartCustomOption } from '../config/option/SmartCustomOption'
import SmartNavigatorObserver from '../helper/SmartNavigatorObserver'
import { SmartAttachOption } from '../config/option/SmartAttachOption'
import { AttachDialogModel } from '../config/model/AttachDialogModel'

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

  show(option: SmartCustomOption) {
    let model = new CustomDialogModel()
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animationTime = option.animationTime
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.routerName = SmartNavigatorObserver.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
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
    model.routerName = SmartNavigatorObserver.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    this.nodeController.inset(model)
    this.dialogList.push(model)
  }

  async dismiss(option?: SmartDismissOption): Promise<void> {
    let dialog = this.findDialog(option?.tag)
    if (!dialog) {
      if (this.nodeController.rootNode?.getFirstChild()?.getFirstChild()) {
        this.nodeController.rootNode?.clearChildren()
      }
      return
    }

    await dialog.dismiss()
    this.dialogList = this.dialogList.filter((item) => item.tag !== dialog?.tag)
  }

  private findDialog(tag?: string): BaseDialogModel | undefined {
    let dialogList = this.dialogList
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

export const dialogProxy = DialogProxy.instance