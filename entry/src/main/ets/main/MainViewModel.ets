import { SmartDialog } from 'ohos_smart_dialog'
import { attachEasy } from '../dialog/attach/Easy'
import { attachLocation } from '../dialog/attach/Location'
import { customMask } from '../dialog/custom/CustomMask'
import { customJumpPage } from '../dialog/custom/JumpPage'
import { customLocation } from '../dialog/custom/LocationDialog'
import { customTag } from '../dialog/custom/TagDialog'
import { customUseArgs } from '../dialog/custom/UseArgs'
import { loadingCustom } from '../dialog/loading/CustomLoading'
import { MainFeature, MainState } from './MainState'

export class MainViewModel {
  mainState: MainState

  constructor(mainState: MainState) {
    this.mainState = mainState
  }

  showDialog(item: string) {
    // custom
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
    }

    // attach
    if (item === MainFeature.attachEasy) {
      attachEasy()
    } else if (item === MainFeature.attachLocation) {
      attachLocation()
    }

    // loading
    if (item === MainFeature.loadingDefault) {
      SmartDialog.showLoading()
    } else if (item === MainFeature.loadingCustom) {
      loadingCustom()
    }
  }
}
