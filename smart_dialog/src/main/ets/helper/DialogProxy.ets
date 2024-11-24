import { DialogNodeController } from '../node_controller/DialogNodeController'
import { SmartDismissOption } from '../model/option/SmartDismissOption'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { CustomDialogModel } from '../dialog/custom/CustomDialogModel'
import { SmartCustomOption } from '../model/option/SmartCustomOption'
import { SmartAttachOption } from '../model/option/SmartAttachOption'
import { AttachDialogModel } from '../dialog/attach/AttachDialogModel'
import { SmartLoadingOption } from '../model/option/SmartLoadingOption'
import { LoadingDialogModel } from '../dialog/loading/LoadingDialogModel'
import { SmartDialog } from '../SmartDialog'
import { SmartAllDialogType } from '../config/EnumConfig'
import { LoadingNodeController } from '../node_controller/LoadingNodeController'
import { SmartBuilder } from '../kit/function'
import { Configuration } from '@kit.AbilityKit'
import { NavigatorObserver } from './NavigatorObserver'


export class DialogProxy {
  private static _instance?: DialogProxy

  private constructor() {
    // 处理暗黑模式
    this.onConfigurationUpdate = (newConfig: Configuration) => {
      this.dialogList.forEach((item) => {
        item.remove()
        item.animation.dialogStartTime = 0
        item.animation.maskStartTime = 0
        this.dialogNodeController.inset(item)
      })

      if (SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })) {
        this.loadingNodeController.update(this.loadingDialog)
      }
    }
  }

  static get instance() {
    return DialogProxy._instance ? DialogProxy._instance : DialogProxy._instance = new DialogProxy()
  }

  dialogList: Array<BaseDialogModel> = []
  loadingDialog: LoadingDialogModel = new LoadingDialogModel()
  dialogNodeController: DialogNodeController = new DialogNodeController()
  loadingNodeController: LoadingNodeController = new LoadingNodeController()
  // default style
  loadingBuilder?: SmartBuilder
  onConfigurationUpdate: (newConfig: Configuration) => void
  navigatorObserve: NavigatorObserver = new NavigatorObserver()

  show(option: SmartCustomOption) {
    let model = new CustomDialogModel()
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animation.setTime(option.animationTime)
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.bindRouter = option.bindRouter ?? this.navigatorObserve.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    model.dialogType = SmartAllDialogType.custom
    model.backType = option.backType
    model.onDismiss = option.onDismiss
    model.usePenetrate = option.usePenetrate
    const keepSingle = option.keepSingle
    model.keepSingle = keepSingle
    model.animationType = option.animationType
    if (keepSingle) {
      this.dialogNodeController.update(model)
    } else {
      this.dialogNodeController.inset(model)
      this.dialogList.push(model)
    }
  }

  showAttach(option: SmartAttachOption) {
    let model = new AttachDialogModel()
    model.targetId = option.targetId
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animation.setTime(option.animationTime)
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.bindRouter = option.bindRouter ?? this.navigatorObserve.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    model.dialogType = SmartAllDialogType.attach
    model.backType = option.backType
    model.onDismiss = option.onDismiss
    model.usePenetrate = option.usePenetrate
    const keepSingle = option.keepSingle
    model.keepSingle = keepSingle
    model.animationType = option.animationType
    if (keepSingle) {
      this.dialogNodeController.update(model)
    } else {
      this.dialogNodeController.inset(model)
      this.dialogList.push(model)
    }
  }

  showLoading(option: SmartLoadingOption) {
    let model = this.loadingDialog = new LoadingDialogModel()
    model.builder = option.builder
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animation.setTime(option.animationTime)
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.bindRouter = this.navigatorObserve.curRouter
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.onMask = option.onMask
    model.dialogType = SmartAllDialogType.loading
    model.backType = option.backType
    model.onDismiss = option.onDismiss
    model.usePenetrate = option.usePenetrate
    model.animationType = option.animationType
    this.loadingNodeController.update(model)
  }

  async dismiss(option?: SmartDismissOption): Promise<void> {
    const dismissTag = option?.tag
    const loadingDialog = this.loadingDialog
    const isExitLoading = SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })
    if (isExitLoading && (dismissTag === undefined || dismissTag === loadingDialog.tag)) {
      await loadingDialog.dismiss(option?.tag)
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