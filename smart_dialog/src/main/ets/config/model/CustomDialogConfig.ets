import { SmartDialogController } from '../../helper/SmartDialogController'

export class CustomDialogOption {
  wrapBuilder?: WrappedBuilder<ESObject>
  wrapBuilderArgs?: ESObject
  controller?: SmartDialogController
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  routerName?: string
}