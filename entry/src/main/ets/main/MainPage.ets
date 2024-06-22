import { randomColor } from '../app/kit/Color'
import { MainState } from './MainState'
import { MainViewModel } from './MainViewModel'

@Builder
export function buildMainPage() {
  MainPage()
}

@Component
struct MainPage {
  state = new MainState()
  viewModel = new MainViewModel(this.state)

  build() {
    Flex({ wrap: FlexWrap.Wrap }) {
      ForEach(this.state.feature, (item: string) => {
        Button(item)
          .backgroundColor(randomColor())
          .constraintSize({ minWidth: 100 })
          .margin(5)
          .onClick(() => this.viewModel.showDialog(item))
      })
    }.width("100%").height("100%").padding(30).margin({ top: 30 })
  }
}


