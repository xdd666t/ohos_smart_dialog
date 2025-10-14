import { SmartCloseType } from "../../config/EnumConfig"

export interface SmartDismissOption {
  tag?: string
  // 可强制关闭不可见的Dialog
  force?: boolean
  // 关闭弹窗时是否不播放动画
  noAnimation?: boolean
  // 关闭类型
  closeType?: SmartCloseType
}