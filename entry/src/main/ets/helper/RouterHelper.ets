import { buildJumPage } from '../pages/JumpPage'
import { RouterInfo } from './RouterInfo'

export class PageName {
  static jumpPage: string = "jumpPage"
}

export class RouterHelper {
  static stack: NavPathStack = new NavPathStack()

  static routeMap: Map<string, RouterInfo> = new Map([
    [PageName.jumpPage, new RouterInfo(new NavPathInfo(PageName.jumpPage, null), wrapBuilder(buildJumPage))],
  ])
}

@Builder
export function pageMap(pageName: string) {
  RouterHelper.routeMap.get(pageName)?.wrapBuilder?.builder(undefined)
}


