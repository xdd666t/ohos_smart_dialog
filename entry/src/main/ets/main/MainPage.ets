import { FeatureItemModel, FeatureTreeModel, MainState } from './MainState'
import { MainViewModel } from './MainViewModel'


@Component
export struct MainPage {
  @State state: MainState = new MainState()
  viewModel = new MainViewModel(this.state)

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.state.tabsController }) {
      ForEach(this.state.treeList, (item: FeatureTreeModel, index: number) => {
        TabContent() {
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(item.items, (subItem: FeatureItemModel) => {
              Text(subItem.title)
                .backgroundColor("#4169E1")
                .constraintSize({ minWidth: 100, minHeight: 46 })
                .margin(10)
                .padding(8)
                .textAlign(TextAlign.Center)
                .fontColor(Color.White)
                .borderRadius(8)
                .onClick(() => this.viewModel.showDialog(subItem.title))
            })
          }.width("100%").height("100%").padding(30).margin({ top: 30 })
        }
        .tabBar(this.tabBuilder(item.title, index))
        .onWillShow(() => this.state.currentIndex = index)
      })
    }.barHeight(100)
  }

  @Builder
  tabBuilder(title: string, targetIndex: number) {
    Text(title)
      .fontColor(this.state.currentIndex === targetIndex ? '#4169E1' : Color.Black)
      .onClick(() => {
        this.state.currentIndex = targetIndex;
        this.state.tabsController.changeIndex(this.state.currentIndex);
      })
  }
}


