import {
  OhosSmartDialog,
  SmartAttachAlignmentType,
  SmartConfigAttach,
  SmartConfigCustom,
  SmartDialog
} from 'ohos_smart_dialog/';
import { pageMap, RouterHelper } from './app/helper/RouterHelper';
import { MainPage } from './main/MainPage';

@Entry
@Component
struct Index {
  aboutToAppear(): void {
    init()
  }

  build() {
    Stack() {
      // here: monitor router
      Navigation(OhosSmartDialog.registerRouter(RouterHelper.stack)) {
        MainPage()
      }
      .mode(NavigationMode.Stack)
      .hideTitleBar(true)
      .navDestination(pageMap)

      // here: init dialog
      OhosSmartDialog()
    }.height('100%').width('100%')
  }

  onBackPress(): boolean | void {
    return OhosSmartDialog.onBackPressed()()
  }
}

function init() {
  // show
  SmartDialog.config.custom.maskColor = "#75000000"
  SmartDialog.config.custom.alignment = Alignment.Center

  // showAttach
  SmartDialog.config.attach.attachAlignmentType = SmartAttachAlignmentType.center

  let isExist = SmartDialog.config.checkExist()
}