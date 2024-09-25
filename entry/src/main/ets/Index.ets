import {
    OhosSmartDialog
} from 'ohos_smart_dialog/';
import { pageMap, RouterHelper } from './app/helper/RouterHelper';
import { MainPage } from './main/MainPage';

@Entry
@Component
struct Index {
  build() {
    Stack() {
      // here: monitor router
      Navigation(RouterHelper.stack) {
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