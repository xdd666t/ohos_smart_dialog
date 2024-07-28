import { delay, SmartBuilder } from '../kit/function'
import { BuilderNode } from '@kit.ArkUI'
import { SmartAllDialogType, SmartBackType } from '../config/EnumConfig'
import { DialogProxy } from '../helper/DialogProxy'

@ObservedV2
class AnimationModel {
  @Trace maskOpacity: number = 0
  @Trace dialogHeight: Length | undefined = undefined
  @Trace dialogWidth: Length | undefined = undefined
  @Trace dialogScale: number = 1
  @Trace dialogOpacity: number = 1
  @Trace dialogPosition?: Edges
  @Trace time?: number
  startTime?: number
  endTime?: number
}

@ObservedV2
export class BaseDialogModel {
  builder?: SmartBuilder
  builderArgs?: ESObject
  alignment?: Alignment
  animation: AnimationModel = new AnimationModel()
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
    const animation = this.animation
    animation.maskOpacity = 1
    await delay(animation.startTime)
  }

  async dismiss(): Promise<void> {
    const animation = this.animation
    animation.maskOpacity = 0
    await delay(animation.endTime)
  }

  remove() {
    DialogProxy.instance.dialogNodeController.remove(this)
  }
}