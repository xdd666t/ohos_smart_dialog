import { SmartConfig } from './config/SmartConfig'
import { DialogProxy } from './dialog_proxy/DialogProxy'
import { randomTag } from './kit/function'
import { SmartDismissOption } from './model/option/SmartDismissOption'
import { SmartCustomOption } from './model/option/SmartCustomOption'
import { SmartAttachOption } from './model/option/SmartAttachOption'

export class SmartDialog {
  static readonly config: SmartConfig = new SmartConfig()

  static show(option: SmartCustomOption) {
    DialogProxy.instance.show({
      builder: option.builder,
      builderArgs: option.builderArgs,
      alignment: option.alignment ?? SmartDialog.config.custom.alignment,
      animationTime: option.animationTime ?? SmartDialog.config.custom.animationTime,
      maskColor: option.maskColor ?? SmartDialog.config.custom.maskColor,
      maskBuilder: option.maskBuilder ?? SmartDialog.config.custom.maskWrapBuild,
      clickMaskDismiss: option.clickMaskDismiss ?? SmartDialog.config.custom.clickMaskDismiss,
      onMask: option.onMask,
      tag: option.tag ?? randomTag(),
    })
  }

  static showAttach(option: SmartAttachOption) {
    DialogProxy.instance.showAttach({
      targetId: option.targetId,
      builder: option.builder,
      builderArgs: option.builderArgs,
      alignment: option.alignment ?? SmartDialog.config.attach.alignment,
      animationTime: option.animationTime ?? SmartDialog.config.attach.animationTime,
      maskColor: option.maskColor ?? SmartDialog.config.attach.maskColor,
      maskBuilder: option.maskBuilder ?? SmartDialog.config.attach.maskWrapBuild,
      clickMaskDismiss: option.clickMaskDismiss ?? SmartDialog.config.attach.clickMaskDismiss,
      onMask: option.onMask,
      tag: option.tag ?? randomTag(),
    })
  }

  static async dismiss(option?: SmartDismissOption): Promise<void> {
    return DialogProxy.instance.dismiss(option)
  }
}
