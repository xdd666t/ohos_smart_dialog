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
import { SmartAllDialogType, SmartNonAnimationType } from '../config/EnumConfig'
import { LoadingNodeController } from '../node_controller/LoadingNodeController'
import { SmartBuilder } from '../kit/Function'
import { Configuration } from '@kit.AbilityKit'
import { NavigatorObserver } from './NavigatorObserver'
import { SmartBaseOption } from '../model/option/SmartBaseOption'


export class DialogProxy {
  private static _instance?: DialogProxy

  private constructor() {
    // 处理暗黑模式
    this.onConfigurationUpdate = (_newConfig: Configuration) => {
      const dialogNodeController = this.dialogNodeController
      this.dialogList.forEach((item) => {
        dialogNodeController.remove(item)
        item.animation.dialogStartTime = 0
        item.animation.maskStartTime = 0
        dialogNodeController.inset(item)
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
    const model = new CustomDialogModel()
    this.syncOptionData(model, option)
    model.builder = option.builder
    const keepSingle = option.keepSingle
    model.keepSingle = keepSingle
    model.dialogType = SmartAllDialogType.custom
    model.bindRouter = option.bindRouter ?? this.navigatorObserve.curRouter

    if (keepSingle) {
      this.dialogNodeController.update(model)
    } else {
      this.dialogNodeController.inset(model)
      this.dialogList.push(model)
    }
  }

  showAttach(option: SmartAttachOption) {
    const model = new AttachDialogModel()
    this.syncOptionData(model, option)
    model.targetId = option.targetId
    model.builder = option.builder
    model.bindRouter = option.bindRouter ?? this.navigatorObserve.curRouter
    model.dialogType = SmartAllDialogType.attach
    const keepSingle = option.keepSingle
    model.keepSingle = keepSingle

    if (keepSingle) {
      this.dialogNodeController.update(model)
    } else {
      this.dialogNodeController.inset(model)
      this.dialogList.push(model)
    }
  }

  showLoading(option: SmartLoadingOption) {
    const model = this.loadingDialog = new LoadingDialogModel()
    this.syncOptionData(model, option)
    model.builder = option.builder
    model.bindRouter = this.navigatorObserve.curRouter
    model.dialogType = SmartAllDialogType.loading

    this.loadingNodeController.update(model)
  }

  syncOptionData(model: BaseDialogModel, option: SmartBaseOption) {
    model.builderArgs = option.builderArgs
    model.alignment = option.alignment
    model.animation.setTime(option.animationTime)
    model.clickMaskDismiss = option.clickMaskDismiss
    model.tag = option.tag
    model.maskColor = option.maskColor
    model.maskBuilder = option.maskBuilder
    model.maskBuilderArgs = option.maskBuilderArgs
    model.onMask = option.onMask
    model.backType = option.backType
    model.onDismiss = option.onDismiss
    model.usePenetrate = option.usePenetrate
    model.animationType = option.animationType
    model.attributeModifier = option.attributeModifier
    this.processNonAnimation(model, option.nonAnimationTypes)
  }

  async dismiss(option?: SmartDismissOption): Promise<void> {
    const dismissTag = option?.tag
    const loadingDialog = this.loadingDialog
    const isExitLoading = SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })
    if (isExitLoading && (dismissTag === undefined || dismissTag === loadingDialog.tag)) {
      await loadingDialog.dismiss(option)
      return
    }

    const dialogList = this.dialogList
    const dialog = this.findDialog(dismissTag, option?.force)
    if (!dialog) {
      const rootNode = this.dialogNodeController.rootNode
      if (dialogList.length === 0 && rootNode?.getFirstChild()) {
        try {
          rootNode?.clearChildren()
        } catch (error) {
        }
      }
      return
    }

    await dialog.dismiss(option)
  }

  findDialog(tag?: string, force?: boolean): BaseDialogModel | undefined {
    const dialogList = this.dialogList
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
      return (dialogInfo?.visible || force) ? dialogInfo : undefined
    }

    for (let i = dialogList.length - 1; i >= 0; i--) {
      const item = dialogList[i]
      if (item.visible || force) {
        return item
      }
    }

    return undefined
  }

  private processNonAnimation(model: BaseDialogModel, nonAnimationTypes?: Array<SmartNonAnimationType>) {
    if (!nonAnimationTypes || nonAnimationTypes.length === 0) {
      return
    }

    const animation = model.animation
    model.nonAnimationTypes = nonAnimationTypes
    nonAnimationTypes.forEach((type: SmartNonAnimationType) => {
      if (type === SmartNonAnimationType.openDialog) {
        animation.dialogStartTime = 0
      }
      if (type === SmartNonAnimationType.closeDialog) {
        animation.dialogEndTime = 0
      }
      if (type === SmartNonAnimationType.openMask) {
        animation.maskStartTime = 0
      }
      if (type === SmartNonAnimationType.closeMask) {
        animation.maskEndTime = 0
      }
    })
  }
}