import { SmartDialogController } from '../../helper/SmartDialogController'

export class CustomDialogOption {
  wrapBuilder?: WrappedBuilder<ESObject>
  wrapBuilderArgs?: ESObject
  alignment?: Alignment
  controller?: SmartDialogController
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  routerName?: string
  maskWrapBuild?: WrappedBuilder<ESObject>
  onMask?: VoidCallback
}