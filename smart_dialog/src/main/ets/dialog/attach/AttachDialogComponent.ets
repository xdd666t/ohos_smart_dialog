import { AttachDialogModel } from './AttachDialogModel';
import { SmartBuilder } from '../../kit/Function';
import { window } from '@kit.ArkUI';


@Component
export struct AttachDialogComponent {
  @BuilderParam builder?: SmartBuilder
  item: AttachDialogModel = new AttachDialogModel()
  @State firstRender: boolean = true
  alreadyStartAnimation: boolean = false
  private windowClass: window.Window | undefined
  private onWindowChange = (windowSize: Size) => {
    // 必须延时，等待目标id坐标回置
    setTimeout(() => {
      const item = this.item
      this.item.setWindowSize(windowSize.width, windowSize.height)
      item.resetLocation()
    }, 100)
  }

  aboutToAppear(): void {
    this.builder = this.item.builder
  }

  build() {
    if (this.firstRender) {
      Stack() {
        this.builder?.(this.item.builderArgs)
      }
      .onSizeChange(() => {
        this.firstRenderSizeChange()
      })
      .visibility(Visibility.Hidden)
      .id(this.item.selfId)
    } else {
      Stack() {
        this.builder?.(this.item.builderArgs)
      }
      .scale({
        x: this.item.animation.dialogScaleX,
        y: this.item.animation.dialogScaleY,
        centerX: this.item.animation.dialogScaleCenterX,
        centerY: this.item.animation.dialogScaleCenterY,
      })
      .position(this.item.animation.dialogPosition)
      .opacity(this.item.animation.dialogOpacity)
      .animation({ duration: this.item.animation.dialogTime, curve: Curve.Linear })
      .gesture(GestureGroup(GestureMode.Exclusive,
        TapGesture(),
        LongPressGesture(),
        PanGesture(),
        PinchGesture(),
        SwipeGesture(),
        RotationGesture(),
      ))
      .onTouch((event: TouchEvent) => event.stopPropagation())
      .onSizeChange(() => {
        if (!this.alreadyStartAnimation) {
          this.alreadyStartAnimation = true
          this.item.show()
        }
      })
      .id(this.item.selfId)
    }
  }

  private firstRenderSizeChange() {
    try {
      window.getLastWindow(getContext(this))?.then((data) => {
        // 获取窗口对象
        const windowClass = this.windowClass = data
        windowClass.off('windowSizeChange', this.onWindowChange)
        const windowRect = windowClass.getWindowProperties().windowRect
        this.item.setWindowSize(windowRect.width, windowRect.height)
        windowClass.on('windowSizeChange', this.onWindowChange)
      }).catch(() => {
      }).finally(() => {
        this.initAnimationStatus()
      })
    } catch (error) {
      this.initAnimationStatus()
    }
  }

  private initAnimationStatus() {
    this.item.initAnimationStatus()
    this.firstRender = false
  }

  aboutToDisappear(): void {
    try {
      this.windowClass?.off('windowSizeChange', this.onWindowChange)
    } catch (error) {
    }
  }
}