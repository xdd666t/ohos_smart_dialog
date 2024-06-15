import { DialogCheckHelper } from '../helper/DialogCheckHelper'
import { CheckExistOption } from './model/CheckExistOption'
import { SmartConfigCustom } from './SmartConfigCustom'

export class SmartConfig {
  custom: SmartConfigCustom = new SmartConfigCustom()

  checkExist(option?: CheckExistOption): boolean {
    return DialogCheckHelper.instance.checkExist(option)
  }
}

