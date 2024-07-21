import { SmartAllDialogType, SmartBackType } from '../config/EnumConfig'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { SmartDialog } from '../SmartDialog'
import { DialogProxy } from './DialogProxy'

export class BackHelper {
  private static _instance?: BackHelper

  private constructor() {
  }

  static get instance() {
    return BackHelper._instance ? BackHelper._instance : BackHelper._instance = new BackHelper()
  }

  onBackPressed(onBack?: () => boolean): () => boolean {
    return () => {
      const dialog = BackHelper.instance.findMultiDialog()

      if (dialog?.backType === SmartBackType.dismiss) {
        SmartDialog.dismiss()
        return true
      } else if (dialog?.backType === SmartBackType.block) {
        return true
      }

      return onBack?.() ?? false
    }
  }

  findMultiDialog(): BaseDialogModel | undefined {
    const dialogProxy = DialogProxy.instance
    if (SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })) {
      return dialogProxy.loadingDialog
    }

    return dialogProxy.findDialog()
  }
}