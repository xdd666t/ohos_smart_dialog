import { OhosSmartDialog } from 'ohos_smart_dialog/';
import { pageMap, RouterHelper } from './helper/RouterHelper';
import { buildMainPage } from './MainPage';

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
}

