import { SmartDialogController } from '../../helper/SmartDialogController'

export class SmartCustomDialogOption {
  wrapBuilder?: WrappedBuilder<ESObject>
  wrapBuilderArgs?: ESObject
  controller?: SmartDialogController
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
}