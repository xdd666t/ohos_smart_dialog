export class MainState {
  feature: Array<string> = [
    MainFeature.location,
    MainFeature.jumpPage,
    MainFeature.customMask,
    MainFeature.tag,
  ]
}

export class MainFeature {
  static location: string = "location"
  static jumpPage: string = "jumpPage"
  static customMask: string = "customMask"
  static tag: string = "tag"
}
