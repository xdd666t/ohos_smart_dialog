import { demoCustomMask } from './dialog/CustomMask'
import { demoJumpPage } from './dialog/JumpPage'
import { demoLocation } from './dialog/LocationDialog'
import { demoTag } from './dialog/TagDialog'
import { targetId } from './dialog/TargetId'
import { demoUseArgs } from './dialog/UseArgs'
import { MainFeature, MainState } from './MainState'


export class MainViewModel {
  mainState: MainState

  constructor(mainState: MainState) {
    this.mainState = mainState
  }

  showDialog(item: string) {
    if (item === MainFeature.useArgs) {
      demoUseArgs()
    } else if (item === MainFeature.location) {
      demoLocation()
    } else if (item === MainFeature.jumpPage) {
      demoJumpPage()
    } else if (item === MainFeature.customMask) {
      demoCustomMask()
    } else if (item === MainFeature.tag) {
      demoTag()
    } else if (item === MainFeature.targetId) {
      targetId(item)
    }
  }
}