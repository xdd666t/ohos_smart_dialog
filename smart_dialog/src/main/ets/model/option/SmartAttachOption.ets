import { SmartBuilder } from '../../kit/Function'
import { SmartBaseOption } from './SmartBaseOption'

export interface SmartAttachOption extends SmartBaseOption {
  builder: SmartBuilder
  targetId: string
  keepSingle?: boolean
  bindRouter?: string
}