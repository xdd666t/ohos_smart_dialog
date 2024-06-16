import { OhosSmartDialog } from 'ohos_smart_dialog/';
import { pageMap, RouterHelper } from './app/helper/RouterHelper';
import { buildMainPage } from './main/MainPage';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Stack() {
      // init
      Navigation(OhosSmartDialog.registerRouter(RouterHelper.stack)) {
        buildMainPage()
      }
      .mode(NavigationMode.Stack)
      .navDestination(pageMap)

      // init
      OhosSmartDialog()
    }.height('100%').width('100%')
  }

  onBackPress(): boolean | void {
    if (OhosSmartDialog.onBackPressed()) {
      return true
    }
    return false
  }
}

