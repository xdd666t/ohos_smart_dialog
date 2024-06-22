import { delay } from '../../kit/function'
import { BuilderNode } from '@kit.ArkUI'
import { DialogProxy } from '../../dialog_proxy/DialogProxy'

@ObservedV2
class AnimationModel {
  @Trace maskOpacity: number = 1
  @Trace dialogScale: number = 1
  @Trace dialogOpacity: number = 1
  @Trace dialogPosition?: Edges
}

@ObservedV2
export class BaseDialogModel {
  builder?: WrappedBuilder<ESObject>
  builderArgs?: ESObject
  alignment?: Alignment
  animation: AnimationModel = new AnimationModel()
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  routerName?: string
  @Trace visible: boolean = true
  maskColor?: ResourceColor
  maskBuilder?: WrappedBuilder<ESObject>
  onMask?: VoidCallback
  builderNode?: BuilderNode<[ESObject]> | null = null

  initAnimationStatus(selfId?: string) {
    const animation = this.animation
    animation.maskOpacity = 0
  }

  async startAnimation(): Promise<void> {
    await delay(this.animationTime)
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