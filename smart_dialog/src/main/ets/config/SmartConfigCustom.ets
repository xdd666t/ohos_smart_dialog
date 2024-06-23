export class SmartConfigCustom {
  constructor() {
  }

  alignment: Alignment = Alignment.Center
  animationTime: number = 200
  clickMaskDismiss: boolean = true
  maskColor: ResourceColor = "#75000000"
  maskWrapBuild?: WrappedBuilder<ESObject>
}