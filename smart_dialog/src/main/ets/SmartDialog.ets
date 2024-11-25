import { SmartConfig } from './config/SmartConfig'
import { DialogProxy } from './helper/DialogProxy'
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

  static get curRouter(): string | undefined {
    return DialogProxy.instance.navigatorObserve.curRouter
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
  ///
  /// [tag]：如果你给dialog设置了tag, 你可以针对性的关闭它
  ///
  /// [backType]: 返回事件对弹窗的影响
  ///
  /// [onDismiss]: 弹窗关闭时, 触发该回调
  ///
  /// [bindRouter]: 当bindRouter为undefined时, 该弹窗将自动绑定当前路由; 如果你不想该弹窗绑定当前路由, 可将该值设置为负数("-1")
  ///
  /// [usePenetrate]: true（点击事件将穿透遮罩），false（不穿透）
  ///
  /// [keepSingle]: keepSingle设置为true，多次调用仍能保持一个弹窗；手动设置tag, 可创建多个同时存在的keepSingle弹窗
  ///
  /// [animationType]: 动画类型
  static show(option: SmartCustomOption) {
    const customConfig = SmartDialog.config.custom
    DialogProxy.instance.show({
      builder: option.builder,
      builderArgs: option.builderArgs,
      alignment: option.alignment ?? customConfig.alignment,
      animationTime: option.animationTime ?? customConfig.animationTime,
      maskColor: option.maskColor ?? customConfig.maskColor,
      maskBuilder: option.maskBuilder ?? customConfig.maskWrapBuild,
      clickMaskDismiss: option.clickMaskDismiss ?? customConfig.clickMaskDismiss,
      onMask: option.onMask,
      tag: option.tag ?? randomTag(option.keepSingle),
      backType: option.backType ?? customConfig.backType,
      onDismiss: option.onDismiss,
      bindRouter: option.bindRouter,
      usePenetrate: option.usePenetrate ?? false,
      keepSingle: option.keepSingle ?? false,
      animationType: option.animationType ?? customConfig.animationType,
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
  ///
  /// [backType]: 返回事件对弹窗的影响
  ///
  /// [onDismiss]: 弹窗关闭时, 触发该回调
  ///
  /// [bindRouter]: 当bindRouter为undefined时, 该弹窗将自动绑定当前路由; 如果你不想该弹窗绑定当前路由, 可将该值设置为负数("-1")
  ///
  /// [usePenetrate]: true（点击事件将穿透遮罩），false（不穿透）
  ///
  /// [keepSingle]: keepSingle设置为true，多次调用仍能保持一个弹窗；手动设置tag, 可创建多个同时存在的keepSingle弹窗
  ///
  /// [animationType]: 动画类型
  static showAttach(option: SmartAttachOption) {
    const attachConfig = SmartDialog.config.attach
    DialogProxy.instance.showAttach({
      targetId: option.targetId,
      builder: option.builder,
      builderArgs: option.builderArgs,
      alignment: option.alignment ?? attachConfig.alignment,
      animationTime: option.animationTime ?? attachConfig.animationTime,
      maskColor: option.maskColor ?? attachConfig.maskColor,
      maskBuilder: option.maskBuilder ?? attachConfig.maskWrapBuild,
      clickMaskDismiss: option.clickMaskDismiss ?? attachConfig.clickMaskDismiss,
      onMask: option.onMask,
      tag: option.tag ?? randomTag(option.keepSingle),
      backType: option.backType ?? attachConfig.backType,
      onDismiss: option.onDismiss,
      bindRouter: option.bindRouter,
      usePenetrate: option.usePenetrate ?? false,
      keepSingle: option.keepSingle ?? false,
      animationType: option.animationType ?? attachConfig.animationType,
    })
  }

  /// loading弹窗
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
  ///
  /// [backType]: 返回事件对弹窗的影响
  ///
  /// [onDismiss]: 弹窗关闭时, 触发该回调
  ///
  /// [usePenetrate]: true（点击事件将穿透遮罩），false（不穿透）
  ///
  /// [animationType]: 动画类型
  static showLoading(option?: SmartLoadingOption) {
    const loadingConfig = SmartDialog.config.loading
    DialogProxy.instance.showLoading({
      builder: option?.builder ?? DialogProxy.instance.loadingBuilder,
      builderArgs: option?.builderArgs,
      alignment: option?.alignment ?? loadingConfig.alignment,
      animationTime: option?.animationTime ?? loadingConfig.animationTime,
      maskColor: option?.maskColor ?? loadingConfig.maskColor,
      maskBuilder: option?.maskBuilder ?? loadingConfig.maskWrapBuild,
      clickMaskDismiss: option?.clickMaskDismiss ?? loadingConfig.clickMaskDismiss,
      onMask: option?.onMask,
      tag: option?.tag,
      backType: option?.backType ?? loadingConfig.backType,
      onDismiss: option?.onDismiss,
      usePenetrate: option?.usePenetrate ?? false,
      animationType: option?.animationType ?? loadingConfig.animationType,
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