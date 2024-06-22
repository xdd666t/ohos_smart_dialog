export class MainState {
  feature: Array<string> = [
    MainFeature.useArgs,
    MainFeature.location,
    MainFeature.jumpPage,
    MainFeature.customMask,
    MainFeature.tag,
    MainFeature.targetId,
  ]
}

export class MainFeature {
  static useArgs: string = "useArgs"
  static location: string = "location"
  static jumpPage: string = "jumpPage"
  static customMask: string = "customMask"
  static tag: string = "tag"
  static targetId: string = "targetId"
}
