@ObservedV2
export class SmartConfigGlobal {
  constructor() {
  }

  // 穿透事件实验性功能能力增强, 默认全局打开
  // 针对特殊场景, 可按需开启或关闭
  @Trace usePenetrate: boolean = true
}