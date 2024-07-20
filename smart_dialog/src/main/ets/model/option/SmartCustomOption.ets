import { SmartBackType } from '../../config/EnumConfig'
import { SmartBuilder } from '../../kit/function'

export class SmartCustomOption {
  builder?: SmartBuilder
  builderArgs?: ESObject
  alignment?: Alignment
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  maskColor?: ResourceColor
  maskBuilder?: SmartBuilder
  onMask?: VoidCallback
  backType?: SmartBackType
}