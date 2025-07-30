import { SmartAllDialogType } from '../../config/EnumConfig'

export class CheckExistOption {
  tag?: string
  dialogTypes?: Array<SmartAllDialogType>
  // 可强制查找不可见的Dialog
  force?: boolean
}