@ObservedV2
export class SmartConfigGlobal {
  constructor() {
  }

  // 穿透事件功能相关场景不稳定, 默认全局关闭
  // 针对特殊场景, 可按需使用前开启, 使用后关闭
  @Trace usePenetrate: boolean = false
}