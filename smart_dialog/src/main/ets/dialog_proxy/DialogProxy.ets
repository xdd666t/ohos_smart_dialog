import { DialogModel } from '../config/model/DialogModel'
import { DialogNodeController } from '../component/DialogNodeController'
import { CustomDialogOption } from '../config/model/CustomDialogConfig'
import { SmartDismissOption } from '../config/option/SmartDismissConfig'

export class DialogProxy {
  private static _instance?: DialogProxy

  private constructor() {
  }

  static get instance() {
    return DialogProxy._instance ? DialogProxy._instance : DialogProxy._instance = new DialogProxy()
  }

  dialogList: Array<DialogModel> = []
  navPathStack: NavPathStack = new NavPathStack()
  nodeController: DialogNodeController = new DialogNodeController()

  show(option: CustomDialogOption) {
    let model = new DialogModel()
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animationTime = option.animationTime
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.routerName = option.routerName
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    this.nodeController.inset(model)
    this.dialogList.push(model)
  }

  optionToDialog(option: CustomDialogOption): DialogModel {
    let model = new DialogModel()
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animationTime = option.animationTime
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.routerName = option.routerName
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    return model
  }

  async dismiss(option?: SmartDismissOption): Promise<void> {
    let dialog = this.findDialog(option?.tag)
    if (!dialog) {
      return
    }

    await dialog.dismiss()
    this.dialogList = this.dialogList.filter((item) => item.tag !== dialog?.tag)
  }

  private findDialog(tag?: string): DialogModel | undefined {
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