import { dialogProxy } from '../../dialog_proxy/DialogProxy'
import { SmartBuilder } from '../../kit/function'
import { MaskComponent } from '../MaskComponent'
import { LoadingDialogModel } from './LoadingDialogModel'

@Component
export struct LoadingNode {
  loadingDialog: LoadingDialogModel = dialogProxy.loadingDialog

  build() {
    if (this.loadingDialog.visible) {
      LoadingDialogComponent({ item: this.loadingDialog })
    } else {
      Stack().visibility(Visibility.None)
    }
  }
}

@Component
struct LoadingDialogComponent {
  @BuilderParam builder?: SmartBuilder
  item: LoadingDialogModel = new LoadingDialogModel()

  aboutToAppear(): void {
    this.builder = this.item.builder
    this.item.initAnimationStatus()
  }

  build() {
    Stack({ alignContent: this.item.alignment }) {
      MaskComponent({ item: this.item })

      Stack() {
        this.builder?.(this.item.builderArgs)
      }
      .scale({ x: this.item.animation.dialogScale, y: this.item.animation.dialogScale })
      .position(this.item.animation.dialogPosition)
      .animation({ duration: this.item.animationTime, curve: Curve.Linear })
      .onAppear(() => {
        this.item.show()
      })
    }
  }
}