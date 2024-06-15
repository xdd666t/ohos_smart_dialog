
export class RouterInfo {
  navPathInfo: NavPathInfo
  wrapBuilder: WrappedBuilder<[Object]>

  constructor(navPathInfo: NavPathInfo, wrapBuilder: WrappedBuilder<[Object]>) {
    this.navPathInfo = navPathInfo
    this.wrapBuilder = wrapBuilder
  }
}

