import { DialogProxy } from '../../helper/DialogProxy'
import { alignmentAnimation } from '../../helper/AlignmentHelper'
import { BaseDialogModel } from '../../model/BaseDialogModel'
import { SmartAnimationType } from '../../config/EnumConfig'

@ObservedV2
export class LoadingDialogModel extends BaseDialogModel {
  constructor() {
    super()

    this.visible = false
  }

  initAnimationStatus(): void {
    this.handleAnimation(true)
    super.initAnimationStatus()
  }

  show(): Promise<void> {
    const animation = this.animation
    animation.setStartTime()
    this.handleAnimation(false)
    return super.show()
  }

  private handleAnimation(beforeRender: boolean) {
    const animation = this.animation
    this.setDialogScale(1)

    // 渐隐动画
    if (this.animationType === SmartAnimationType.fade) {
      animation.dialogOpacity = beforeRender ? 0 : 1
      return
    }

    // 位移动画
    alignmentAnimation(this.alignment, {
      onStart: () => {
        animation.dialogPosition = beforeRender ? { right: "100%" } : { left: 0 }
      },
      onTop: () => {
        animation.dialogPosition = beforeRender ? { bottom: "100%" } : { top: 0 }
      },
      onEnd: () => {
        animation.dialogPosition = beforeRender ? { left: "100%" } : { right: 0 }
      },
      onBottom: () => {
        animation.dialogPosition = beforeRender ? { top: "100%" } : { bottom: 0 }
      },
      onCenter: () => {
        this.setDialogScale(beforeRender ? 0 : 1)
        animation.dialogPosition = undefined
      },
    })
  }

  private setDialogScale(scale: number) {
    const animation = this.animation
    animation.dialogScaleX = scale
    animation.dialogScaleY = scale
  }

  async dismiss(tag?: string): Promise<void> {
    if (tag && tag !== this.tag) {
      return
    }
    const animation = this.animation
    animation.setEndTime()
    this.initAnimationStatus()
    await super.dismiss()
    this.remove()
  }

  remove(): void {
    DialogProxy.instance.loadingNodeController.clearChildren()
  }
}