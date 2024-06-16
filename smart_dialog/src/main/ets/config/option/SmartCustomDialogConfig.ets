import { SmartDialogController } from '../../helper/SmartDialogController'

export class SmartCustomDialogOption {
  wrapBuilder?: WrappedBuilder<ESObject>
  wrapBuilderArgs?: ESObject
  alignment?: Alignment
  controller?: SmartDialogController
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  maskWrapBuild?: WrappedBuilder<ESObject>
  onMask?: VoidCallback
}