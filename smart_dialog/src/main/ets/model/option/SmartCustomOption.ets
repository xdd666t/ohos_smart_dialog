import { SmartAnimationType, SmartBackType } from '../../config/EnumConfig'
import { SmartBuilder } from '../../kit/function'

export interface SmartCustomOption {
  builder: SmartBuilder
  builderArgs?: ESObject
  alignment?: Alignment
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  maskColor?: ResourceColor
  maskBuilder?: SmartBuilder
  onMask?: VoidCallback
  backType?: SmartBackType
  onDismiss?: VoidCallback
  bindRouter?: string
  usePenetrate?: boolean
  keepSingle?: boolean
  animationType?: SmartAnimationType
}