import { DialogModel } from '../config/model/DialogModel'
import { CustomDialogOption } from '../config/model/CustomDialogConfig'

@ObservedV2
export class DialogProxyState {
  originDialogList: Array<CustomDialogOption> = []
  @Trace dialogList: Array<DialogModel> = []
  @Trace visibleDialog: boolean = false
}
