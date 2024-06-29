import { SmartBuilder } from '../kit/function'
import { CustomDialogModel } from '../model/CustomDialogModel'

@Component
export struct CustomDialogComponent {
  @BuilderParam builder?: SmartBuilder
  item: CustomDialogModel = new CustomDialogModel()

  aboutToAppear(): void {
    this.builder = this.item.builder
    this.item.initAnimationStatus()
  }

  build() {
    Stack() {
      this.builder?.(this.item.builderArgs)
    }
    .scale({ x: this.item.animation.dialogScale, y: this.item.animation.dialogScale })
    .position(this.item.animation.dialogPosition)
    .onAppear(() => this.item.startAnimation())
  }
}