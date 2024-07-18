export class MainState {
  @Track tabsController: TabsController = new TabsController()
  @Track currentIndex: number = 0
  @Track treeList: Array<FeatureTreeModel> = [
    {
      title: "show",
      items: [
        { title: MainFeature.customUseArgs },
        { title: MainFeature.customLocation },
        { title: MainFeature.customJumpPage },
        { title: MainFeature.customMask },
        { title: MainFeature.customTag },
      ]
    },
    {
      title: "showAttach",
      items: [
        { title: MainFeature.attachLocation },
      ]
    },
    {
      title: "showLoading",
      items: [
        { title: MainFeature.loadingShow },
      ]
    },
  ]
}


export class MainFeature {
  // show
  static customUseArgs: string = "customUseArgs"
  static customLocation: string = "customLocation"
  static customJumpPage: string = "customJumpPage"
  static customMask: string = "customMask"
  static customTag: string = "customTag"
  // attach
  static attachLocation: string = "attachLocation"
  // loading
  static loadingShow: string = "loadingShow"
}


export class FeatureTreeModel {
  title: string = ""
  items: Array<FeatureItemModel> = []
}

export class FeatureItemModel {
  title: string = ""
}