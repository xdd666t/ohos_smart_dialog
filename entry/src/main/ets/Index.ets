import { OhosSmartDialog } from 'ohos_smart_dialog/';
import { pageMap, RouterHelper } from './app/helper/RouterHelper';
import { buildMainPage } from './main/MainPage';

@Entry
@Component
struct Index {
  build() {
    Stack() {
      // here: monitor router
      Navigation(OhosSmartDialog.registerRouter(RouterHelper.stack)) {
        buildMainPage()
      }
      .mode(NavigationMode.Stack)
      .navDestination(pageMap)

      // here: init dialog
      OhosSmartDialog()
    }.height('100%').width('100%')
  }

  onBackPress(): boolean | void {
    return OhosSmartDialog.onBackPressed()()
  }
}

