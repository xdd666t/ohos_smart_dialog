import { attachLocation } from '../dialog/attach/Location'
import { customMask } from '../dialog/custom/CustomMask'
import { customJumpPage } from '../dialog/custom/JumpPage'
import { customLocation } from '../dialog/custom/LocationDialog'
import { customTag } from '../dialog/custom/TagDialog'
import { customUseArgs } from '../dialog/custom/UseArgs'
import { MainFeature, MainState } from './MainState'

export class MainViewModel {
  mainState: MainState

  constructor(mainState: MainState) {
    this.mainState = mainState
  }

  showDialog(item: string) {
    if (item === MainFeature.customUseArgs) {
      customUseArgs()
    } else if (item === MainFeature.customLocation) {
      customLocation()
    } else if (item === MainFeature.customJumpPage) {
      customJumpPage()
    } else if (item === MainFeature.customMask) {
      customMask()
    } else if (item === MainFeature.customTag) {
      customTag()
    } else if (item === MainFeature.attachLocation) {
      attachLocation()
    }
  }
}
