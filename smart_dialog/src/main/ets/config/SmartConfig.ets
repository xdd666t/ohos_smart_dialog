import { SmartConfigAttach } from './SmartConfigAttach'
import { SmartConfigCustom } from './SmartConfigCustom'
import { SmartConfigGlobal } from './SmartConfigGlobal'
import { SmartConfigLoading } from './SmartConfigLoading'

export class SmartConfig {
  custom: SmartConfigCustom = new SmartConfigCustom()
  attach: SmartConfigAttach = new SmartConfigAttach()
  loading: SmartConfigLoading = new SmartConfigLoading()
  global: SmartConfigGlobal = new SmartConfigGlobal()
}

