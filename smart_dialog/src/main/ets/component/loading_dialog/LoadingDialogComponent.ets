import { onBlockClick, SmartBuilder } from '../../kit/function'
import { MaskComponent } from '../MaskComponent'
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
      this.builder?.(this.item.builderArgs)
    }
    .scale({ x: this.item.animation.dialogScale, y: this.item.animation.dialogScale })
    .position(this.item.animation.dialogPosition)
    .animation({ duration: this.item.animation.time, curve: Curve.Linear })
    .onAppear(() => {
      this.item.show()
    })
    .onClick(() => onBlockClick())
  }
}