import { GestureComponent } from '../../component/GestureComponent'
import { SmartPenetrateType } from '../../config/EnumConfig'
import { SmartBuilder } from '../../kit/Function'
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
      GestureComponent({ usePenetrate: this.item.penetrateTypes.includes(SmartPenetrateType.dialog) }) {
        this.builder?.(this.item.builderArgs)
      }
    }
    .scale({ x: this.item.animation.dialogScaleX, y: this.item.animation.dialogScaleY })
    .opacity(this.item.animation.dialogOpacity)
    .position(this.item.animation.dialogPosition)
    .animation({ duration: this.item.animation.dialogTime, curve: Curve.Linear })
    .onTouch((event: TouchEvent) => event.stopPropagation())
    .onAppear(() => this.item.show())
  }
}