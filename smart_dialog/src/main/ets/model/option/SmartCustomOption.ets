import { SmartAnimationType, SmartBackType, SmartNonAnimationType } from '../../config/EnumConfig'
import { SmartBuilder } from '../../kit/Function'
import { StackModifier } from '@kit.ArkUI'

export interface SmartCustomOption {
  builder: SmartBuilder
  builderArgs?: ESObject
  alignment?: Alignment
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  maskColor?: ResourceColor
  maskBuilder?: SmartBuilder
  maskBuilderArgs?: ESObject
  onMask?: VoidCallback
  backType?: SmartBackType
  onDismiss?: VoidCallback
  bindRouter?: string
  usePenetrate?: boolean
  keepSingle?: boolean
  animationType?: SmartAnimationType
  nonAnimationTypes?: Array<SmartNonAnimationType>
  attributeModifier?: AttributeModifier<StackModifier>
}