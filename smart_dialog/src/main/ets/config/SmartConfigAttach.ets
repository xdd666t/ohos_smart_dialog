import { SmartBuilder } from '../kit/Function'
import { SmartAnimationType, SmartAttachAlignmentType, SmartBackType, SmartNonAnimationType } from './EnumConfig'

export class SmartConfigAttach {
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
  alignment: Alignment = Alignment.Bottom
  /// [animationTime]：可设置动画时间
  animationTime: number = 200
  /// true（点击遮罩关闭dialog），false（不关闭）
  clickMaskDismiss: boolean = true
  /// 遮罩颜色：[maskWrapBuild]参数设置了数据，该参数会失效
  maskColor: ResourceColor = "#75000000"
  /// 可高度定制遮罩
  maskWrapBuild?: SmartBuilder
  /// attach dialog选择不同alignment属性时的对齐效果, 具体说明请参照[SmartAttachAlignmentType]
  attachAlignmentType: SmartAttachAlignmentType = SmartAttachAlignmentType.center
  /// 返回事件对弹窗的影响
  backType: SmartBackType = SmartBackType.dismiss
  // 动画类型
  animationType: SmartAnimationType = SmartAnimationType.scale
  /// 对于不同的场景, 可动态关闭弹窗动画, 具体请参照[SmartNonAnimationType]
  nonAnimationTypes: Array<SmartNonAnimationType> = []
}