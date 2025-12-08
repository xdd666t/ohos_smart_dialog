import { GestureComponent } from '../../component/GestureComponent'
import { SmartPenetrateType } from '../../config/EnumConfig'
import { SmartBuilder } from '../../kit/Function'
import { LoadingDialogModel } from './LoadingDialogModel'


@Component
export struct LoadingDialogComponent {
  @BuilderParam builder?: SmartBuilder
  item: LoadingDialogModel = new LoadingDialogModel()

  aboutToAppear(): void {
    this.builder = this.item.builder
    this.item.initAnimationStatus()
  }

  build() {
    Stack({ alignContent: this.item.alignment }) {
      GestureComponent({ usePenetrate: this.item.penetrateTypes.includes(SmartPenetrateType.dialog) }) {
        this.builder?.(this.item.builderArgs)
      }
    }
    .scale({ x: this.item.animation.dialogScaleX, y: this.item.animation.dialogScaleY })
    .opacity(this.item.animation.dialogOpacity)
    .position(this.item.animation.dialogPosition)
    .animation({ duration: this.item.animation.dialogTime, curve: Curve.Linear })
    .onAppear(() => {
      this.item.show()
    })
  }
}