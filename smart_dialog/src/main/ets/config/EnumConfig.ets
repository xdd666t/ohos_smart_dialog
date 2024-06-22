
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
