import { alignmentAnimation } from '../../helper/AlignmentHelper'
import { delay } from '../../kit/function'
import { BuilderNode } from '@kit.ArkUI'
import { DialogProxy } from '../../dialog_proxy/DialogProxy'

@ObservedV2
class AnimationModel {
  @Trace maskOpacity: number = 0
  @Trace mainScale: number = 0
  @Trace position?: Edges
}

@ObservedV2
export class DialogModel {
  builder?: WrappedBuilder<ESObject>
  builderArgs?: ESObject
  alignment?: Alignment
  animation: AnimationModel = new AnimationModel()
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  routerName?: string
  @Trace visible: boolean = true
  maskBuilder?: WrappedBuilder<ESObject>
  onMask?: VoidCallback
  builderNode?: BuilderNode<[ESObject]> | null = null

  onAppear() {
    this.initAnimationStatus()
  }

  initAnimationStatus() {
    const animation = this.animation
    alignmentAnimation(this.alignment, {
      onStart: () => {
        animation.mainScale = 1
        animation.position = { right: "100%" }
      },
      onTop: () => {
        animation.mainScale = 1
        animation.position = { bottom: "100%" }
      },
      onEnd: () => {
        animation.mainScale = 1
        animation.position = { left: "100%" }
      },
      onBottom: () => {
        animation.mainScale = 1
        animation.position = { top: "100%" }
      },
      onCenter: () => {
        animation.mainScale = 0
        animation.position = undefined
      },
    })
    animation.maskOpacity = 0
  }

  async startAnimation(): Promise<void> {
    const animation = this.animation
    const animationTime = this.animationTime
    animateTo({ duration: animationTime, curve: Curve.Linear }, () => {
      alignmentAnimation(this.alignment, {
        onStart: () => {
          animation.position = { left: 0 }
        },
        onTop: () => {
          animation.position = { top: 0 }
        },
        onEnd: () => {
          animation.position = { right: 0 }
        },
        onBottom: () => {
          animation.position = { bottom: 0 }
        },
        onCenter: () => {
          animation.position = undefined
        },
      })
      animation.mainScale = 1
    })
    await delay(animationTime)
  }

  async endAnimation(): Promise<void> {
    const animationTime = this.animationTime
    animateTo({ duration: animationTime, curve: Curve.Linear }, () => {
      this.initAnimationStatus()
    })

    await delay(animationTime)
  }


  async dismiss(): Promise<void> {
    await this.endAnimation()
    this.remove()
  }

  remove() {
    DialogProxy.instance.nodeController.remove(this)
  }
}