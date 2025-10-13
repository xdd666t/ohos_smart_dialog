import { SmartBuilder } from '../../kit/Function'
import { SmartBaseOption } from './SmartBaseOption'

export interface SmartCustomOption extends SmartBaseOption {
  builder: SmartBuilder
  keepSingle?: boolean
  bindRouter?: string
}