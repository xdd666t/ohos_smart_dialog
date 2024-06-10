import { DialogModel } from '../config/model/DialogModel'

@Component
export struct MainComponent {
  item: DialogModel = new DialogModel()

  build() {
    NodeContainer(this.item.dialogNode).scale({ x: this.item.mainScale, y: this.item.mainScale })
      .onAppear(() => {
        animateTo({
          duration: this.item.animationTime,
          curve: Curve.Linear,
        }, () => {
          this.item.maskOpacity = 0.3
          this.item.mainScale = 1
        })
      })
  }
}