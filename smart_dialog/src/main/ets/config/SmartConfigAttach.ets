import { SmartAttachAlignmentType } from './EnumConfig'

export class SmartConfigAttach {
  constructor() {
  }

  alignment: Alignment = Alignment.Bottom
  animationTime: number = 200
  clickMaskDismiss: boolean = true
  maskColor: ResourceColor = "#75000000"
  maskWrapBuild?: WrappedBuilder<ESObject>
  /// attach dialog选择不同alignment属性时的对齐效果, 具体说明请参照[SmartAttachAlignmentType]
  attachAlignmentType: SmartAttachAlignmentType = SmartAttachAlignmentType.center
}