import { alignmentAnimation } from '../../helper/AlignmentHelper'
import { DialogNodeController } from '../../helper/DialogNodeController'
import { SmartDialogController } from '../../helper/SmartDialogController'
import { delay } from '../../kit/function'
import { AnimationModel } from './AnimationModel'

export class DialogModel {
  alignment?: Alignment
  animation: AnimationModel = new AnimationModel()
  dialogNode?: DialogNodeController
  controller?: SmartDialogController
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  routerName?: string
  visible: boolean = true
  maskWrapBuild?: WrappedBuilder<ESObject>
  onMask?: VoidCallback
  isOld: boolean = false

  initAnimationModel() {
    alignmentAnimation(this.alignment, {
      onStart: () => {
        this.animation.mainScale = 1
        this.animation.position = { x: "-100%" }
      },
      onTop: () => {
        this.animation.mainScale = 1
        this.animation.position = { y: "-100%" }
      },
      onEnd: () => {
        this.animation.mainScale = 1
        this.animation.position = { x: "100%" }
      },
      onBottom: () => {
        this.animation.mainScale = 1
        this.animation.position = { y: "100%" }
      },
      onCenter: () => {
        this.animation.mainScale = 0
        this.animation.position = undefined
      },
    })
    this.animation.maskOpacity = 0
  }


  async dismiss(): Promise<void> {
    animateTo({ duration: this.animationTime, curve: Curve.Linear }, () => {
      this.initAnimationModel()
    })

    await delay(this.animationTime)
  }
}