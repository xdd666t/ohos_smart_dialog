/// dialog type
export enum SmartAllDialogType {
  /// custom dialog（show）
  custom,

  /// attach dialog（showAttach）
  attach,

  /// notify dialog（showNotify）
  // notify,

  /// loading（showLoading）
  loading,

  /// toast（showToast）
  // toast,
}

// enum SmartCloseType {
//   /// close single dialog：loading（showToast），custom（show）or attach（showAttach）
//   ///
//   /// 关闭单个dialog：loading（showLoading），custom（show）或 attach（showAttach）
//   smart,
//
//   /// close toast（showToast）
//   ///
//   /// 关闭toast（showToast）
//   toast,
//
//   /// close all toasts（showToast）
//   ///
//   /// 关闭所有toast（showToast）
//   allToast,
//
//   /// close loading（showLoading）
//   ///
//   /// 关闭loading（showLoading）
//   loading,
//
//   /// close single custom dialog（show）
//   ///
//   /// 关闭单个custom dialog（show）
//   custom,
//
//   /// close single attach dialog（showAttach）
//   ///
//   /// 关闭单个attach dialog（showAttach）
//   attach,
//
//   /// close single dialog（attach or custom）
//   ///
//   /// 关闭单个dialog（attach或custom）
//   dialog,
//
//   /// close single notify
//   ///
//   /// 关闭单个notify
//   notify,
//
//   /// close all custom dialog, but not close toast,loading and attach dialog
//   ///
//   /// 关闭打开的所有custom dialog，但是不关闭toast，loading和attach dialog
//   allCustom,
//
//   /// close all attach dialog, but not close toast,loading and custom dialog
//   ///
//   /// 关闭打开的所有attach dialog，但是不关闭toast，loading和custom dialog
//   allAttach,
//
//   /// close all dialog（attach and custom）, but not close toast and loading
//   ///
//   /// 关闭打开的所有dialog（attach和custom），但是不关闭toast和loading
//   allDialog,
//
//   /// close all notify
//   ///
//   /// 关闭打开的所有notify
//   allNotify,
// }

/// attach dialog选择不同alignment属性时的对齐效果
export enum SmartAttachAlignmentType {

  /// attach dialog对齐目标控件内边缘, 注意: Alignment.centerXxx不受影响, 依旧是中心点对齐;
  /// Alignment.bottomLeft/topLeft(dialog左边边缘对齐目标控件左侧边缘), Alignment.bottomRight/topRight((dialog右边边缘对齐目标控件右侧边缘))
  inside,


  /// attach dialog的中心点对齐目标控件边缘
  /// Alignment.bottomLeft/topLeft(dialog中心点对齐目标控件左侧边缘), Alignment.bottomRight/topRight(dialog中心点对齐目标控件右侧边缘)
  center,

  /// attach dialog对齐目标控件外边缘, 注意: Alignment.centerXxx不受影响, 依旧是中心点对齐;
  /// Alignment.bottomLeft/topLeft(dialog右边边缘对齐目标控件左侧边缘), Alignment.bottomRight/topRight((dialog左边边缘对齐目标控件右侧边缘))
  outside,
}

/// 返回事件对弹窗的影响
export enum SmartBackType {
  /// 消费返回事件: 返回事件将关闭弹窗, 且拦截返回事件继续向后传递
  dismiss,

  /// 阻塞返回事件: 返回事件无法关闭弹窗, 且拦截返回事件继续向后传递
  block,

  /// 忽略返回事件: 返回事件不会关闭弹窗, 且返回事件继续向后传递
  ignore,
}

/// 可给弹窗(出现和消失)设置不同的动画类型
export enum SmartAnimationType {
  /// 全部位置都为渐隐动画
  fade,

  /// 中间位置的为缩放, 其他位置为类位移动画
  scale,
}

/// 对于不同的场景, 可动态关闭弹窗动画
export enum SmartNonAnimationType {
  /// 打开dialog, 弹窗无开始动画
  openDialog,

  /// 所有场景关闭弹窗, 弹窗无结束动画
  closeDialog,

  /// 打开dialog, 遮罩无开始动画
  openMask,

  /// 打开dialog, 遮罩无结束动画
  closeMask,

  /// keepSingle弹窗连续调用, 间隔无动画
  continueKeepSingle,
}