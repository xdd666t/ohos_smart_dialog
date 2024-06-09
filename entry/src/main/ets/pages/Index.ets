import { MainPage } from 'ohos_smart_dialog/Index';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      MainPage()
    }
    .height('100%')
    .width('100%')
  }
}