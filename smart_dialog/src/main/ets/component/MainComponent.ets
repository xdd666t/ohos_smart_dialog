import { DialogModel } from '../config/model/DialogModel'
import { alignmentAnimation } from '../helper/AlignmentHelper'

@Component
export struct MainComponent {
  item: DialogModel = new DialogModel()

  aboutToAppear(): void {
    if (!this.item.isOld) {
      this.item.initAnimationModel()
    }
  }

  build() {
    NodeContainer(this.item.nodeController)
      .scale({ x: this.item.animation.mainScale, y: this.item.animation.mainScale })
      .position(this.item.animation.position)
      .onAppear(() => this.onComponentAppear())
  }

  private onComponentAppear(): void {
    animateTo({ duration: this.item.animationTime, curve: Curve.Linear }, () => {
      let item = this.item
      alignmentAnimation(item.alignment, {
        onStart: () => {
          item.animation.position = { left: 0 }
        },
        onTop: () => {
          item.animation.position = { top: 0 }
        },
        onEnd: () => {
          item.animation.position = { right: 0 }
        },
        onBottom: () => {
          item.animation.position = { bottom: 0 }
        },
        onCenter: () => {
          item.animation.position = undefined
        },
      })
      item.animation.mainScale = 1
    })
  }
}