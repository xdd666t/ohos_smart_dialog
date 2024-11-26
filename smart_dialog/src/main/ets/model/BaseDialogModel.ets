import { delay, SmartBuilder } from '../kit/function'
import { BuilderNode } from '@kit.ArkUI'
import { SmartAllDialogType, SmartAnimationType, SmartBackType } from '../config/EnumConfig'
import { DialogProxy } from '../helper/DialogProxy'

@ObservedV2
class AnimationModel {
  @Trace maskOpacity: number = 0
  @Trace dialogScaleX: number = 1
  @Trace dialogScaleY: number = 1
  @Trace dialogScaleCenterX?: number
  @Trace dialogScaleCenterY?: number
  @Trace dialogOpacity: number = 1
  @Trace dialogPosition?: Edges
  @Trace dialogTime?: number
  @Trace maskTime?: number
  dialogStartTime?: number
  dialogEndTime?: number
  maskStartTime?: number
  maskEndTime?: number

  setTime(time?: number) {
    this.dialogStartTime = time
    this.maskStartTime = time
    this.dialogEndTime = time
    this.maskEndTime = time
  }

  setStartTime() {
    this.dialogTime = this.dialogStartTime
    this.maskTime = this.maskStartTime
  }

  setEndTime() {
    this.dialogTime = this.dialogEndTime
    this.maskTime = this.maskEndTime
  }
}

@ObservedV2
export class BaseDialogModel {
  builder?: SmartBuilder
  builderArgs?: ESObject
  alignment?: Alignment
  animation: AnimationModel = new AnimationModel()
  clickMaskDismiss?: boolean
  tag?: string
  bindRouter?: string
  @Trace visible: boolean = true
  maskColor?: ResourceColor
  maskBuilder?: SmartBuilder
  onMask?: VoidCallback
  builderNode?: BuilderNode<[ESObject]> | null = null
  dialogType?: SmartAllDialogType
  backType?: SmartBackType
  onDismiss?: VoidCallback
  usePenetrate?: boolean
  animationType?: SmartAnimationType

  initAnimationStatus() {
    const animation = this.animation
    animation.maskOpacity = (animation.maskStartTime === 0 ? 1 : 0)
  }

  async show(): Promise<void> {
    const animation = this.animation
    animation.maskOpacity = 1
    await delay(animation.dialogStartTime)
  }

  async dismiss(): Promise<void> {
    this.onDismiss?.()

    const animation = this.animation
    animation.maskOpacity = (animation.maskEndTime === 0 ? 1 : 0)
    await delay(animation.dialogEndTime)
  }

  remove() {
    const dialogProxy = DialogProxy.instance
    dialogProxy.dialogList = dialogProxy.dialogList.filter((item) => item.tag !== this?.tag)
    dialogProxy.dialogNodeController.remove(this)
  }
}