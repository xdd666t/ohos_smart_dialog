import { SmartConfigAttach } from './SmartConfigAttach'
import { SmartConfigCustom } from './SmartConfigCustom'
import { SmartConfigLoading } from './SmartConfigLoading'

export class SmartConfig {
  custom: SmartConfigCustom = new SmartConfigCustom()
  attach: SmartConfigAttach = new SmartConfigAttach()
  loading: SmartConfigLoading = new SmartConfigLoading()
}

