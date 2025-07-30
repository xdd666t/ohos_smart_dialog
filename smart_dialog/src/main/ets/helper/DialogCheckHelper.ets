import { CheckExistOption } from '../model/option/CheckExistOption'
import { SmartAllDialogType } from '../config/EnumConfig'
import { DialogProxy } from './DialogProxy'

export class DialogCheckHelper {
  private static _instance?: DialogCheckHelper

  private constructor() {
  }

  static get instance() {
    return DialogCheckHelper._instance ? DialogCheckHelper._instance :
      DialogCheckHelper._instance = new DialogCheckHelper()
  }

  checkExist(option?: CheckExistOption): boolean {
    const dialogTypes = option?.dialogTypes ?? [
      SmartAllDialogType.custom,
      SmartAllDialogType.attach,
      SmartAllDialogType.loading,
    ]
    const force = option?.force ?? false
    const tag = option?.tag
    const dialogProxy = DialogProxy.instance

    if (tag) {
      return (dialogProxy.findDialog(tag, force) !== undefined)
    }

    let result = false
    if (!result && dialogTypes?.includes(SmartAllDialogType.custom)) {
      result = this.isExistDialog(SmartAllDialogType.custom, force)
    }
    if (!result && dialogTypes?.includes(SmartAllDialogType.attach)) {
      result = this.isExistDialog(SmartAllDialogType.attach, force)
    }
    if (!result && dialogTypes?.includes(SmartAllDialogType.loading)) {
      result = dialogProxy.loadingNodeController.rootNode?.getFirstChild() !== null
    }

    return result
  }

  private isExistDialog(dialogType: SmartAllDialogType, force?: boolean): boolean {
    const dialogProxy = DialogProxy.instance
    let isExist = false
    for (let item of dialogProxy.dialogList) {
      if ((item.visible || force) && item.dialogType === dialogType) {
        isExist = true
        break
      }
    }
    return isExist
  }
}