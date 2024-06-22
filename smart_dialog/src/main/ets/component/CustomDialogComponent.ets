import { CustomDialogModel } from '../config/model/CustomDialogModel'

@Component
export struct CustomDialogComponent {
  item: CustomDialogModel = new CustomDialogModel()

  aboutToAppear(): void {
    this.item.initAnimationStatus()
  }

  build() {
    Stack() {
      this.item.builder?.builder(this.item.builderArgs)
    }
    .scale({ x: this.item.animation.dialogScale, y: this.item.animation.dialogScale })
    .position(this.item.animation.dialogPosition)
    .onAppear(() => this.item.startAnimation())
  }
}