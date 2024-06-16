import { randomColor } from '../../app/kit/Color'

@Builder
export function dialogCustomMask() {
  Stack().width("100%").height("100%").backgroundColor(randomColor()).opacity(0.6)
}


