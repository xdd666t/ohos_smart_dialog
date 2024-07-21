import { DialogProxy } from '../../helper/DialogProxy'
import { alignmentAnimation } from '../../helper/AlignmentHelper'
import { BaseDialogModel } from '../../model/BaseDialogModel'

@ObservedV2
export class LoadingDialogModel extends BaseDialogModel {
  constructor() {
    super()

    this.visible = false
  }

  initAnimationStatus(): void {
    const animation = this.animation
    alignmentAnimation(this.alignment, {
      onStart: () => {
        animation.dialogScale = 1
        animation.dialogPosition = { right: "100%" }
      },
      onTop: () => {
        animation.dialogScale = 1
        animation.dialogPosition = { bottom: "100%" }
      },
      onEnd: () => {
        animation.dialogScale = 1
        animation.dialogPosition = { left: "100%" }
      },
      onBottom: () => {
        animation.dialogScale = 1
        animation.dialogPosition = { top: "100%" }
      },
      onCenter: () => {
        animation.dialogScale = 0
        animation.dialogPosition = undefined
      },
    })
    super.initAnimationStatus()
  }

  show(): Promise<void> {
    const animation = this.animation
    animation.time = animation.startTime
    alignmentAnimation(this.alignment, {
      onStart: () => {
        animation.dialogPosition = { left: 0 }
      },
      onTop: () => {
        animation.dialogPosition = { top: 0 }
      },
      onEnd: () => {
        animation.dialogPosition = { right: 0 }
      },
      onBottom: () => {
        animation.dialogPosition = { bottom: 0 }
      },
      onCenter: () => {
        animation.dialogPosition = undefined
      },
    })
    animation.dialogScale = 1
    return super.show()
  }


  async dismiss(): Promise<void> {
    const animation = this.animation
    animation.time = animation.endTime
    this.initAnimationStatus()
    await super.dismiss()
    this.remove()
  }

  remove(): void {
    DialogProxy.instance.loadingNodeController.clearChildren()
  }
}