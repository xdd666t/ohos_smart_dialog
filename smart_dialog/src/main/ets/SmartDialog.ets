import { SmartConfig } from './config/SmartConfig'
import { DialogProxy } from './dialog_proxy/DialogProxy'
import { randomTag } from './kit/function'
import { SmartDismissOption } from './model/option/SmartDismissOption'
import { SmartCustomOption } from './model/option/SmartCustomOption'
import { SmartAttachOption } from './model/option/SmartAttachOption'
import { SmartLoadingOption } from './model/option/SmartLoadingOption'
import { CheckExistOption } from './model/option/CheckExistOption'
import { DialogCheckHelper } from './helper/DialogCheckHelper'
import { SmartAllDialogType } from './config/EnumConfig'

export class SmartDialog {
  static readonly config: SmartConfig = new SmartConfig()

  /// custom弹窗
  ///
  /// [builder]：自定义 dialog
  ///
  /// [builderArgs]：传参
  ///
  /// [alignment]：控制弹窗的位置, 详细请参照[SmartConfigCustom]中alignment参数说明
  ///
  /// [animationTime]：动画持续时间
  ///
  /// [maskColor]：遮罩颜色，如果给[maskWidget]设置了值，该参数将会失效
  ///
  /// [maskBuilder]：可高度定制遮罩
  ///
  /// [clickMaskDismiss]：true（点击遮罩后，将关闭dialog），false（不关闭）
  ///
  /// [onMask]：点击遮罩时，该回调将会被触发
  ///
  /// [tag]：如果你给dialog设置了tag, 你可以针对性的关闭它
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

  /// attach弹窗
  ///
  /// [targetId]: 你需要定位的component的id
  ///
  /// [builder]：自定义 dialog
  ///
  /// [builderArgs]：传参
  ///
  /// [alignment]：控制弹窗的位置, 详细请参照[SmartConfigCustom]中alignment参数说明
  ///
  /// [animationTime]：动画持续时间
  ///
  /// [maskColor]：遮罩颜色，如果给[maskWidget]设置了值，该参数将会失效
  ///
  /// [maskBuilder]：可高度定制遮罩
  ///
  /// [clickMaskDismiss]：true（点击遮罩后，将关闭dialog），false（不关闭）
  ///
  /// [onMask]：点击遮罩时，该回调将会被触发
  ///
  /// [tag]：如果你给dialog设置了tag, 你可以针对性的关闭它
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

  /// custom弹窗
  ///
  /// [builder]：自定义 dialog
  ///
  /// [builderArgs]：传参
  ///
  /// [alignment]：控制弹窗的位置, 详细请参照[SmartConfigCustom]中alignment参数说明
  ///
  /// [animationTime]：动画持续时间
  ///
  /// [maskColor]：遮罩颜色，如果给[maskWidget]设置了值，该参数将会失效
  ///
  /// [maskBuilder]：可高度定制遮罩
  ///
  /// [clickMaskDismiss]：true（点击遮罩后，将关闭dialog），false（不关闭）
  ///
  /// [onMask]：点击遮罩时，该回调将会被触发
  static showLoading(option: SmartLoadingOption) {
    DialogProxy.instance.showLoading({
      builder: option.builder,
      builderArgs: option.builderArgs,
      alignment: option.alignment ?? SmartDialog.config.custom.alignment,
      animationTime: option.animationTime ?? SmartDialog.config.custom.animationTime,
      maskColor: option.maskColor ?? SmartDialog.config.custom.maskColor,
      maskBuilder: option.maskBuilder ?? SmartDialog.config.custom.maskWrapBuild,
      clickMaskDismiss: option.clickMaskDismiss ?? SmartDialog.config.custom.clickMaskDismiss,
      onMask: option.onMask,
    })
  }

  /// 关闭dialog
  ///
  /// [tag]：如果你想关闭指定的dialog，你可以给它设置一个tag
  static async dismiss(option?: SmartDismissOption): Promise<void> {
    return DialogProxy.instance.dismiss(option)
  }

  /// 检查弹窗是否存在
  static checkExist(option?: CheckExistOption): boolean {
    return DialogCheckHelper.instance.checkExist(option ?? {
      dialogTypes: [
        SmartAllDialogType.custom,
        SmartAllDialogType.attach,
        SmartAllDialogType.loading,
      ]
    })
  }
}