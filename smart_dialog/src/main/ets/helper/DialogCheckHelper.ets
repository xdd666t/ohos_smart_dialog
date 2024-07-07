import { CheckExistOption } from '../model/option/CheckExistOption'
import { dialogProxy } from '../dialog_proxy/DialogProxy'
import { SmartAllDialogType } from '../config/EnumConfig'
import { SmartDialog } from '../SmartDialog'

export class DialogCheckHelper {
  private static _instance?: DialogCheckHelper

  private constructor() {
  }

  static get instance() {
    return DialogCheckHelper._instance ? DialogCheckHelper._instance :
      DialogCheckHelper._instance = new DialogCheckHelper()
  }

  checkExist(option: CheckExistOption): boolean {
    let dialogTypes = option.dialogTypes

    if (option?.tag && (dialogProxy.findDialog(option?.tag) !== undefined)) {
      return true
    }

    let result = false
    if (!result && dialogTypes?.includes(SmartAllDialogType.custom)) {
      result = this.isExistDialog(SmartAllDialogType.custom)
    }
    if (!result && dialogTypes?.includes(SmartAllDialogType.attach)) {
      result = this.isExistDialog(SmartAllDialogType.attach)
    }
    if (!result && dialogTypes?.includes(SmartAllDialogType.loading)) {
      result = dialogProxy.loadingDialog.visible
    }

    return result
  }

  private isExistDialog(dialogType: SmartAllDialogType): boolean {
    let isExist = false
    for (let item of dialogProxy.dialogList) {
      if (item.visible && item.dialogType === dialogType) {
        isExist = true
        break
      }
    }
    return isExist
  }
}