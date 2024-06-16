import { SmartConfig } from './config/SmartConfig'
import { DialogProxy } from './dialog_proxy/DialogProxy'
import { randomTag } from './kit/function'
import { SmartCustomDialogOption } from './config/option/SmartCustomDialogConfig'
import SmartNavigatorObserver from './helper/SmartNavigatorObserver'
import { SmartDismissOption } from './config/option/SmartDismissConfig'

export class SmartDialog {
  static readonly config: SmartConfig = new SmartConfig()

  static show(option: SmartCustomDialogOption) {
    DialogProxy.instance.show({
      wrapBuilder: option.wrapBuilder,
      wrapBuilderArgs: option.wrapBuilderArgs,
      alignment: option.alignment ?? SmartDialog.config.custom.alignment,
      controller: option.controller,
      animationTime: option.animationTime ?? SmartDialog.config.custom.animationTime,
      maskWrapBuild: option.maskWrapBuild ?? SmartDialog.config.custom.maskWrapBuild,
      clickMaskDismiss: option.clickMaskDismiss ?? SmartDialog.config.custom.clickMaskDismiss,
      onMask: option.onMask,
      tag: option.tag ?? randomTag(),
      routerName: SmartNavigatorObserver.curRouter,
    })
  }

  static async dismiss(option?: SmartDismissOption): Promise<void> {
    return DialogProxy.instance.dismiss(option)
  }
}
