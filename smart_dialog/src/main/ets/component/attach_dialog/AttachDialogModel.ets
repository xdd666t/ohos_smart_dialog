import { BaseDialogModel } from '../../model/BaseDialogModel'
import { componentUtils, display, Offset } from '@kit.ArkUI'
import { SmartDialog } from '../../SmartDialog'
import { SmartAttachAlignmentType } from '../../config/EnumConfig'

@ObservedV2
export class AttachDialogModel extends BaseDialogModel {
  targetId: string = ''
  private attachInfo = new AttachInfo()

  constructor() {
    super()
    this.animation.dialogOpacity = 0
    this.animation.dialogScale = 1
    this.animation.dialogPosition = undefined
  }

  initAnimationStatus(selfId?: string): void {
    const animation = this.animation
    const attachInfo = this.attachInfo
    attachInfo.targetInfo = componentUtils.getRectangleById(this.targetId)
    attachInfo.selfInfo = componentUtils.getRectangleById(selfId ?? '')

    let targetRect = this.handleLocation()
    animation.dialogPosition = {
      left: px2vp(targetRect.left),
      top: px2vp(targetRect.top),
      right: px2vp(targetRect.right),
      bottom: px2vp(targetRect.bottom),
    } as Edges
    super.initAnimationStatus()
  }

  show(): Promise<void> {
    const animation = this.animation
    animation.dialogOpacity = 1
    return super.show()
  }

  async dismiss(): Promise<void> {
    this.animation.dialogOpacity = 0
    await super.dismiss()
    this.remove()
  }

  /// 处理: 方向及其位置
  private handleLocation(): RectInfo {
    const attachInfo = this.attachInfo
    let alignment = this.alignment
    let targetRect = new RectInfo()
    let targetOffset = attachInfo.targetInfo?.screenOffset ?? {} as Offset
    let targetSize = attachInfo.targetInfo?.size ?? {} as Size
    let selfSize = attachInfo.selfInfo?.size ?? {} as Size
    let screen = attachInfo.screen
    if (alignment == Alignment.TopStart) {
      targetRect = this.adjustReactInfo({
        bottom: screen.height - targetOffset.y,
        left: targetOffset.x + this.calculateDx(),
        fixedVertical: true,
      })
    } else if (alignment == Alignment.Top) {
      targetRect = this.adjustReactInfo({
        bottom: screen.height - targetOffset.y,
        left: targetOffset.x + targetSize.width / 2 - selfSize.width / 2,
        fixedVertical: true,
      })
    } else if (alignment == Alignment.TopEnd) {
      targetRect = this.adjustReactInfo({
        bottom: screen.height - targetOffset.y,
        left: targetOffset.x + targetSize.width + this.calculateDx(),
        fixedVertical: true,
      })
    } else if (alignment == Alignment.Start) {
      targetRect = this.adjustReactInfo({
        right: screen.width - targetOffset.x,
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
    let rectInfo: RectInfo = {
      left: option.left,
      right: option.right,
      top: option.top,
      bottom: option.bottom
    }
    const attachInfo = this.attachInfo
    let selfSize = attachInfo.selfInfo?.size ?? {} as Size
    let screen = attachInfo.screen

    //处理左右边界问题
    if (!option.fixedHorizontal && option.left !== undefined) {
      if (option.left < 0) {
        rectInfo.left = 0
        rectInfo.right = undefined
      } else {
        let rightEdge = screen.width - option.left - selfSize.width
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
        let bottomEdge = screen.height - option.top - selfSize.height
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
    let type = SmartDialog.config.attach.attachAlignmentType
    const attachInfo = this.attachInfo
    let alignment = this.alignment
    let selfSize = attachInfo.selfInfo?.size ?? {} as Size

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