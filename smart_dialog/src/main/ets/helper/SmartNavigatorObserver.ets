import { DialogProxy } from './DialogProxy'
import { safeReturn } from '../kit/function'

export default class SmartNavigatorObserver implements NavigationInterception {
  curRouter?: string
  // 开始显示
  willShow?: InterceptionShowCallback =
    (from: NavDestinationContext | NavBar,
      to: NavDestinationContext | NavBar,
      operation: NavigationOperation,
      isAnimated: boolean) => {
      this.curRouter = safeReturn(() => {
        return (to as NavDestinationContext).navDestinationId
      })
      if (operation === NavigationOperation.PUSH) {
        this.onPush(from, to)
      } else if (operation === NavigationOperation.REPLACE) {
        this.onReplace(from, to)
      } else if (operation === NavigationOperation.POP) {
        this.onPop(from, to)
      }
      this.dialogVisible()
      // safeUse(() => {
      //   let fromCtx = from as NavDestinationContext
      //   let toCtx = to as NavDestinationContext
      //   console.info(`SmartNavigatorObserver:from:${fromCtx.navDestinationId},to:${toCtx.navDestinationId}`)
      // })
    }
  //结束显示
  didShow?: InterceptionShowCallback = (from, to, operation, isAnimated) => {
  }

  private onPush(from: NavDestinationContext | NavBar, to: NavDestinationContext | NavBar) {
  }

  private onReplace(from: NavDestinationContext | NavBar, to: NavDestinationContext | NavBar) {
    this.popRouter(from, to)
  }

  private onPop(from: NavDestinationContext | NavBar, to: NavDestinationContext | NavBar) {
    this.popRouter(from, to)
  }

  private popRouter(from: NavDestinationContext | NavBar, to: NavDestinationContext | NavBar) {
    let popRouter: string | undefined = safeReturn(() => {
      return (from as NavDestinationContext).navDestinationId
    })
    DialogProxy.instance.dialogList.filter((item) => {
      let isAccess = item.bindRouter !== popRouter
      if (!isAccess) {
        item.remove()
      }

      return isAccess
    })
  }

  private dialogVisible() {
    DialogProxy.instance.dialogList.forEach((item) => {
      item.visible = this.curRouter === item.bindRouter
    })
  }
}
