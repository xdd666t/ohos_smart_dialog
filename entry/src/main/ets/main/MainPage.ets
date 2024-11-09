import { FeatureItemModel, FeatureTreeModel, MainState } from './MainState'
import { MainViewModel } from './MainViewModel'


@Component
export struct MainPage {
  @State state: MainState = new MainState()
  viewModel = new MainViewModel(this.state)

  build() {
    Scroll() {
      Column() {
        ForEach(this.state.treeList, (item: FeatureTreeModel, index: number) => {
          Column() {
            Text(item.title).fontSize(20).fontWeight(FontWeight.Bold)
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
                  .onClick(() => {
                    this.viewModel.showDialog(subItem.title)
                  })
              })
            }
          }.alignItems(HorizontalAlign.Start).width("100%").padding(30)
        })

        Stack().height(300)
      }
    }.margin({ top: 30 })
  }
}


