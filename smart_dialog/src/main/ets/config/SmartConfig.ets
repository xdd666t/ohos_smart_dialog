import { DialogCheckHelper } from '../helper/DialogCheckHelper'
import { CheckExistOption } from '../model/option/CheckExistOption'
import { SmartConfigAttach } from './SmartConfigAttach'
import { SmartConfigCustom } from './SmartConfigCustom'

export class SmartConfig {
  custom: SmartConfigCustom = new SmartConfigCustom()
  attach: SmartConfigAttach = new SmartConfigAttach()

  checkExist(option?: CheckExistOption): boolean {
    return DialogCheckHelper.instance.checkExist(option)
  }
}

