import { BaseDialogModel } from '../../model/BaseDialogModel'
import { componentUtils, display, Offset } from '@kit.ArkUI'
import { SmartDialog } from '../../SmartDialog'
import { SmartAnimationType, SmartAttachAlignmentType } from '../../config/EnumConfig'
import { ViewUtil } from '../../kit/ViewUtil'
import { randomTag } from '../../kit/Function'

@ObservedV2
export class AttachDialogModel extends BaseDialogModel {
  targetId: string = ''
  keepSingle?: boolean
  private attachInfo = new AttachInfo()
  readonly selfId: string = randomTag()
  private windowWidth: number = display.getDefaultDisplaySync().availableWidth
  private windowHeight: number = display.getDefaultDisplaySync().availableHeight

  constructor() {
    super()
    const animation = this.animation
    animation.dialogOpacity = 0
    animation.dialogScaleX = 0
    animation.dialogScaleY = 0
    animation.dialogPosition = undefined
  }

  initAnimationStatus(): void {
    this.animation.setStartTime()
    this.resetLocation()
    this.handleAnimation(true)
    super.initAnimationStatus()
  }

  resetLocation() {
    const attachInfo = this.attachInfo
    attachInfo.targetInfo = ViewUtil.getRectangleById(this.targetId)
    attachInfo.screen = {
      width: this.windowWidth,
      height: this.windowHeight,
    }
    attachInfo.selfInfo = ViewUtil.getRectangleById(this.selfId)
    const targetRect = this.handleLocation()
    this.animation.dialogPosition = {
      left: px2vp(targetRect.left),
      top: px2vp(targetRect.top),
      right: px2vp(targetRect.right),
      bottom: px2vp(targetRect.bottom),
    } as Edges
  }

  show(): Promise<void> {
    this.handleAnimation(false)
    return super.show()
  }

  async dismiss(): Promise<void> {
    const animation = this.animation
    animation.setEndTime()
    // 恢复到渲染前状态
    this.handleAnimation(true)
    await super.dismiss()
    this.remove()
  }

  private handleAnimation(beforeRender: boolean) {
    const animation = this.animation

    // 渐隐动画
    if (this.animationType === SmartAnimationType.fade) {
      animation.dialogScaleX = 1
      animation.dialogScaleY = 1
      animation.dialogOpacity = beforeRender ? 0 : 1
      return
    }

    // 类位移动画
    const alignment = this.alignment
    let selfSize = {} as Size
    if (beforeRender) {
      selfSize = ViewUtil.getRectangleById(this.selfId)?.size ?? ({} as Size)
    } else {
      selfSize = this.attachInfo.selfInfo?.size ?? ({} as Size)
    }
    const selfWidth = px2vp(selfSize.width ?? 0)
    const selfHeight = px2vp(selfSize.height ?? 0)
    animation.dialogOpacity = 1
    animation.dialogScaleCenterX = undefined
    animation.dialogScaleCenterY = undefined
    if (alignment == Alignment.TopStart || alignment == Alignment.Top || alignment == Alignment.TopEnd) {
      animation.dialogScaleX = 1
      animation.dialogScaleY = beforeRender ? 0 : 1
      animation.dialogScaleCenterY = selfHeight
    } else if (alignment == Alignment.Start) {
      animation.dialogScaleX = beforeRender ? 0 : 1
      animation.dialogScaleCenterX = selfWidth
      animation.dialogScaleY = 1
    } else if (alignment == Alignment.Center) {
      animation.dialogScaleX = beforeRender ? 0 : 1
      animation.dialogScaleY = beforeRender ? 0 : 1
    } else if (alignment == Alignment.End) {
      animation.dialogScaleX = beforeRender ? 0 : 1
      animation.dialogScaleCenterX = 0
      animation.dialogScaleY = 1
    } else if (alignment == Alignment.BottomStart || alignment == Alignment.Bottom ||
      alignment == Alignment.BottomEnd) {
      animation.dialogScaleX = 1
      animation.dialogScaleY = beforeRender ? 0 : 1
      animation.dialogScaleCenterY = 0
    }
  }

  /// 处理: 方向及其位置
  private handleLocation(): RectInfo {
    const attachInfo = this.attachInfo
    const alignment = this.alignment
    let targetRect = new RectInfo()
    const screenSize = attachInfo.screen
    const targetOffset = attachInfo.targetInfo?.windowOffset ?? {} as Offset
    const targetSize = attachInfo.targetInfo?.size ?? {} as Size
    const selfSize = attachInfo.selfInfo?.size ?? {} as Size
    if (alignment == Alignment.TopStart) {
      targetRect = this.adjustReactInfo({
        bottom: screenSize.height - targetOffset.y,
        left: targetOffset.x + this.calculateDx(),
        fixedVertical: true,
      })
    } else if (alignment == Alignment.Top) {
      targetRect = this.adjustReactInfo({
        bottom: screenSize.height - targetOffset.y,
        left: targetOffset.x + targetSize.width / 2 - selfSize.width / 2,
        fixedVertical: true,
      })
    } else if (alignment == Alignment.TopEnd) {
      targetRect = this.adjustReactInfo({
        bottom: screenSize.height - targetOffset.y,
        left: targetOffset.x + targetSize.width + this.calculateDx(),
        fixedVertical: true,
      })
    } else if (alignment == Alignment.Start) {
      targetRect = this.adjustReactInfo({
        right: screenSize.width - targetOffset.x,
        top: targetOffset.y + targetSize.height / 2 - selfSize.height / 2,
        fixedHorizontal: true,
      })
    } else if (alignment == Alignment.Center) {
      targetRect = this.adjustReactInfo({
        left: targetOffset.x + targetSize.width / 2 - selfSize.width / 2,
        top: targetOffset.y + targetSize.height / 2 - selfSize.height / 2,
        fixedHorizontal: true,
      })
    } else if (alignment == Alignment.End) {
      targetRect = this.adjustReactInfo({
        left: targetOffset.x + targetSize.width,
        top: targetOffset.y + targetSize.height / 2 - selfSize.height / 2,
        fixedHorizontal: true,
      })
    } else if (alignment == Alignment.BottomStart) {
      targetRect = this.adjustReactInfo({
        top: targetOffset.y + targetSize.height,
        left: targetOffset.x + this.calculateDx(),
        fixedVertical: true,
      })
    } else if (alignment == Alignment.Bottom) {
      targetRect = this.adjustReactInfo({
        top: targetOffset.y + targetSize.height,
        left: targetOffset.x + targetSize.width / 2 - selfSize.width / 2,
        fixedVertical: true,
      })
    } else if (alignment == Alignment.BottomEnd) {
      targetRect = this.adjustReactInfo({
        top: targetOffset.y + targetSize.height,
        left: targetOffset.x + targetSize.width + this.calculateDx(),
        fixedVertical: true,
      })
    }

    return targetRect
  }


  private adjustReactInfo(option: AdjustRectInfo): RectInfo {
    const rectInfo: RectInfo = {
      left: option.left,
      right: option.right,
      top: option.top,
      bottom: option.bottom
    }
    const attachInfo = this.attachInfo
    const selfSize = attachInfo.selfInfo?.size ?? {} as Size
    const screen = attachInfo.screen

    //处理左右边界问题
    if (!option.fixedHorizontal && option.left !== undefined) {
      if (option.left < 0) {
        rectInfo.left = 0
        rectInfo.right = undefined
      } else {
        const rightEdge = screen.width - option.left - selfSize.width
        if (rightEdge < 0) {
          rectInfo.left = undefined
          rectInfo.right = 0
        }
      }
    }

    //处理上下边界问题
    if (!option.fixedVertical && option.top !== undefined) {
      if (option.top < 0) {
        rectInfo.top = 0
        rectInfo.bottom = undefined
      } else {
        const bottomEdge = screen.height - option.top - selfSize.height
        if (bottomEdge < 0) {
          rectInfo.top = undefined
          rectInfo.bottom = 0
        }
      }
    }

    return rectInfo
  }

  /// 计算attach alignment类型的偏移量
  private calculateDx() {
    let offset: number = 0
    const type = SmartDialog.config.attach.attachAlignmentType
    const attachInfo = this.attachInfo
    const alignment = this.alignment
    const selfSize = attachInfo.selfInfo?.size ?? {} as Size

    if (alignment == Alignment.TopStart || alignment == Alignment.BottomStart) {
      if (type == SmartAttachAlignmentType.inside) {
        offset = 0;
      } else if (type == SmartAttachAlignmentType.outside) {
        offset = -selfSize.width;
      } else {
        offset = -(selfSize.width / 2);
      }
    } else if (alignment == Alignment.TopEnd || alignment == Alignment.BottomEnd) {
      if (type == SmartAttachAlignmentType.inside) {
        offset = -selfSize.width;
      } else if (type == SmartAttachAlignmentType.outside) {
        offset = 0;
      } else {
        offset = -(selfSize.width / 2);
      }
    }

    return offset;
  }

  setWindowSize(width: number, height: number) {
    this.windowWidth = width
    this.windowHeight = height
  }
}

class RectInfo {
  left?: number
  right?: number
  top?: number
  bottom?: number
}

class AdjustRectInfo {
  left?: number
  right?: number
  top?: number
  bottom?: number
  fixedHorizontal?: boolean
  fixedVertical?: boolean
}

class AttachInfo {
  targetInfo?: componentUtils.ComponentInfo
  selfInfo?: componentUtils.ComponentInfo
  screen: ScreenInfo = {
    width: screenWidth,
    height: screenHeight,
  }
}

class ScreenInfo {
  width: number = 0
  height: number = 0
}

const screenWidth = display.getDefaultDisplaySync().width
const screenHeight = display.getDefaultDisplaySync().height