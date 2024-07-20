import { SmartBuilder } from '../kit/function'
import { SmartBackType } from './EnumConfig'

export class SmartConfigCustom {
  constructor() {
  }

  /// 控制dialog位于屏幕的位置
  ///
  /// Center: dialog位于屏幕中间
  ///
  /// BottomStart、Bottom、BottomEnd：dialog位于屏幕底部
  ///
  /// TopStart、Top、TopEnd：dialog位于屏幕顶部
  ///
  /// Start：dialog位于屏幕左边
  ///
  /// End：dialog位于屏幕左边
  alignment: Alignment = Alignment.Center
  /// [animationTime]：可设置动画时间
  animationTime: number = 200
  /// true（点击遮罩关闭dialog），false（不关闭）
  clickMaskDismiss: boolean = true
  /// 遮罩颜色：[maskWrapBuild]参数设置了数据，该参数会失效
  maskColor: ResourceColor = "#75000000"
  /// 可高度定制遮罩
  maskWrapBuild?: SmartBuilder
  /// 返回事件对弹窗的影响
  backType: SmartBackType = SmartBackType.dismiss
}