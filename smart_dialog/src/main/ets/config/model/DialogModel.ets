import { DialogNodeController } from '../../helper/DialogNodeController'
import { SmartDialogController } from '../../helper/SmartDialogController'

@ObservedV2
export class DialogModel {
  @Trace maskOpacity: number = 0
  @Trace mainScale: number = 0
  dialogNode?: DialogNodeController
  controller?: SmartDialogController
  animationTime?: number
  clickMaskDismiss?: boolean
  tag?: string
  routerName?: string
  visible: boolean = true
}