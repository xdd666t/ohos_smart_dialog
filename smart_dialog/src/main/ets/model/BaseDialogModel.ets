import { delay, SmartBuilder } from '../kit/function'
import { BuilderNode } from '@kit.ArkUI'
import { DialogProxy } from '../dialog_proxy/DialogProxy'
import { SmartAllDialogType, SmartBackType } from '../config/EnumConfig'

@ObservedV2
class AnimationModel {
  @Trace maskOpacity: number = 0
  @Trace dialogHeight: Length | undefined = undefined
  @Trace dialogWidth: Length | undefined = undefined
  @Trace dialogScale: number = 1
  @Trace dialogOpacity: number = 1
  @Trace dialogPosition?: Edges
}

@ObservedV2
export class BaseDialogModel {
  builder?: SmartBuilder
  builderArgs?: ESObject
  alignment?: Alignment
  animation: AnimationModel = new AnimationModel()
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  router?: string
  @Trace visible: boolean = true
  maskColor?: ResourceColor
  maskBuilder?: SmartBuilder
  onMask?: VoidCallback
  builderNode?: BuilderNode<[ESObject]> | null = null
  dialogType?: SmartAllDialogType
  backType?: SmartBackType

  initAnimationStatus() {
    const animation = this.animation
    animation.maskOpacity = 0
  }

  async show(): Promise<void> {
    this.animation.maskOpacity = 1
    await delay(this.animationTime)
  }

  async dismiss(): Promise<void> {
    this.animation.maskOpacity = 0
    await delay(this.animationTime)
  }

  remove() {
    DialogProxy.instance.nodeController.remove(this)
  }
}