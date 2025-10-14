import { SmartAllDialogType } from '../config/EnumConfig'
import { SmartDismissOption } from '../model/option/SmartDismissOption'
import { SmartDialog } from '../SmartDialog'
import { DialogProxy } from './DialogProxy'

export class CloseHelper {
  public static async loadingDismiss(option?: SmartDismissOption): Promise<void> {
    const isExitLoading = SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })
    if (!isExitLoading) {
      return
    }
    await DialogProxy.instance.loadingDialog.dismiss(option)
  }

  public static async customDismiss(option?: SmartDismissOption): Promise<void> {
    const dialogProxy = DialogProxy.instance
    const dialogInfo = dialogProxy.findDialog(option?.tag, option?.force, SmartAllDialogType.custom)
    if (!dialogInfo) {
      return
    }
    await dialogInfo.dismiss(option)
  }

  public static async attachDismiss(option?: SmartDismissOption): Promise<void> {
    const dialogProxy = DialogProxy.instance
    const dialogInfo = dialogProxy.findDialog(option?.tag, option?.force, SmartAllDialogType.attach)
    if (!dialogInfo) {
      return
    }
    await dialogInfo.dismiss(option)
  }

  public static async allDialogDismiss(option?: SmartDismissOption): Promise<void> {
    try {
      const dialogProxy = DialogProxy.instance
      const closeDialogList: Array<Promise<void>> = []
      // 处理显示的dialog
      const dialogList = dialogProxy.dialogList
      for (let index = dialogList.length - 1; index >= 0; index--) {
        const item = dialogList[index]
        if (item && (item.visible || option?.force)) {
          closeDialogList.push(item.dismiss(option))
        }
      }
      await Promise.all(closeDialogList)
    } catch (_) {
    }
  }

  public static async smartDismiss(option?: SmartDismissOption): Promise<void> {
    const dialogProxy = DialogProxy.instance
    const loadingDialog = dialogProxy.loadingDialog
    const isExitLoading = SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })
    const dismissTag = option?.tag
    if (isExitLoading && (dismissTag === undefined || dismissTag === loadingDialog.tag)) {
      await loadingDialog.dismiss(option)
      return
    }

    const dialogList = dialogProxy.dialogList
    const dialog = dialogProxy.findDialog(dismissTag, option?.force)
    if (!dialog) {
      const rootNode = dialogProxy.dialogNodeController.rootNode
      if (dialogList.length === 0 && rootNode?.getFirstChild()) {
        try {
          rootNode?.clearChildren()
        } catch (error) {
        }
      }
      return
    }

    await dialog.dismiss(option)
  }
}