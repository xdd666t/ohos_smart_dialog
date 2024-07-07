import { DialogCheckHelper } from '../helper/DialogCheckHelper'
import { CheckExistOption } from '../model/option/CheckExistOption'
import { SmartAllDialogType } from './EnumConfig'
import { SmartConfigAttach } from './SmartConfigAttach'
import { SmartConfigCustom } from './SmartConfigCustom'
import { SmartConfigLoading } from './SmartConfigLoading'

export class SmartConfig {
  custom: SmartConfigCustom = new SmartConfigCustom()
  attach: SmartConfigAttach = new SmartConfigAttach()
  loading: SmartConfigLoading = new SmartConfigLoading()

  checkExist(option?: CheckExistOption): boolean {
    return DialogCheckHelper.instance.checkExist(option ?? {
      dialogTypes: [
        SmartAllDialogType.custom,
        SmartAllDialogType.attach,
        SmartAllDialogType.loading,
      ]
    })
  }
}

