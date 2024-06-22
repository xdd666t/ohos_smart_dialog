import { DialogModel } from '../config/model/DialogModel'

@Component
export struct MainComponent {
  item: DialogModel = new DialogModel()

  aboutToAppear(): void {
    this.item.onAppear()
  }

  build() {
    Stack() {
      this.item.builder?.builder(this.item.builderArgs)
    }
    .scale({ x: this.item.animation.mainScale, y: this.item.animation.mainScale })
    .position(this.item.animation.position)
    .onAppear(() => this.item.startAnimation())
  }
}