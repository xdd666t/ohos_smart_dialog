import { onBlockClick, SmartBuilder } from '../../kit/function'
import { CustomDialogModel } from './CustomDialogModel'

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
    .animation({ duration: this.item.animation.dialogTime, curve: Curve.Linear })
    .onAppear(() => this.item.show())
    .onClick(() => onBlockClick())
  }
}