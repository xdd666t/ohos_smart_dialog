import { SmartConfig } from './config/SmartConfig'
import { DialogProxy } from './dialog_proxy/DialogProxy'
import { randomTag } from './kit/function'
import { SmartCustomDialogOption } from './config/option/SmartCustomDialogConfig'

export class SmartDialog {
  static readonly config: SmartConfig = new SmartConfig()

  static show(option: SmartCustomDialogOption) {
    DialogProxy.instance.show({
      wrapBuilder: option.wrapBuilder,
      wrapBuilderArgs: option.wrapBuilderArgs,
      controller: option.controller,
      animationTime: option.animationTime ?? SmartDialog.config.custom.animationTime,
      clickMaskDismiss: option.clickMaskDismiss ?? SmartDialog.config.custom.clickMaskDismiss,
      tag: option.tag ?? randomTag(),
    })
  }

  static async dismiss(): Promise<void> {
    return DialogProxy.instance.dismiss()
  }
}
