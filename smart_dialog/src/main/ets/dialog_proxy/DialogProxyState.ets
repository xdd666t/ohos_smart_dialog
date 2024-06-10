import { SmartCustomDialogOption } from '../config/option/SmartCustomDialogConfig'
import { DialogModel } from '../config/model/DialogModel'

@ObservedV2
export class DialogProxyState {
  optionDialogList: Array<SmartCustomDialogOption> = []
  @Trace dialogList: Array<DialogModel> = []
}
