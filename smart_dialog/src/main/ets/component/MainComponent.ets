import { DialogModel } from '../config/model/DialogModel'

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
      this.item.animation.mainScale = 1
      this.item.animation.position = undefined
    })
  }
}