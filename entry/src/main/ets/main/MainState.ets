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
        { title: MainFeature.customKeepSingle },
        { title: MainFeature.customUsePenetrate },
        { title: MainFeature.customHalfPenetrate },
      ]
    },
    {
      title: "showAttach",
      items: [
        { title: MainFeature.attachEasy },
        { title: MainFeature.attachLocation },
      ]
    },
    {
      title: "showLoading",
      items: [
        { title: MainFeature.loadingDefault },
        { title: MainFeature.loadingCustom },
      ]
    },
    {
      title: "globalConfig",
      items: [
        { title: MainFeature.globalUsePenetrate },
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
  static customKeepSingle: string = "customKeepSingle"
  static customUsePenetrate: string = "customUsePenetrate"
  static customHalfPenetrate: string = "customHalfPenetrate"
  // attach
  static attachEasy: string = "attachEasy"
  static attachLocation: string = "attachLocation"
  // loading
  static loadingDefault: string = "loadingDefault"
  static loadingCustom: string = "loadingCustom"
  // global
  static globalUsePenetrate: string = "globalUsePenetrate"
}


export class FeatureTreeModel {
  title: string = ""
  items: Array<FeatureItemModel> = []
}

export class FeatureItemModel {
  title: string = ""
}