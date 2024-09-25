import { DialogProxy } from './DialogProxy'
import { uiObserver } from '@kit.ArkUI'

/**
 * @className: DialogNavigatorObserver
 * @author: Hide Name
 * @create: 2024-09-23 15:57
 */
export class NavigatorObserver {
  private backgroundRouterIdSet = new Set<string | undefined>()
  curRouter?: string

  registerNavSwitch(context: UIContext) {
    uiObserver.on('navDestinationSwitch', context, this.navDestinationSwitch)
  }

  unregisterNavSwitch(context: UIContext) {
    uiObserver.off('navDestinationSwitch', context, this.navDestinationSwitch)
  }

  private navDestinationSwitch = (info: uiObserver.NavDestinationSwitchInfo) => {
    const navigatorObserve = DialogProxy.instance.navigatorObserve
    const fromId = this.getNavId(info.from)
    const toId = this.getNavId(info.to)
    switch (info.operation) {
      case NavigationOperation.PUSH:
        navigatorObserve.onPush(fromId, toId)
        break;
      case NavigationOperation.POP:
        navigatorObserve.onPop(fromId, toId)
        break;
      case NavigationOperation.REPLACE:
        navigatorObserve.onReplace(fromId, toId)
        break;
    }
    this.updateDialogVisibleState()
    // console.info(`DialogNavigatorObserver:${JSON.stringify(info)}`)
  }

  private onPush(fromId?: string, toId?: string) {
    this.backgroundRouterIdSet.add(fromId)
    DialogProxy.instance.navigatorObserve.curRouter = toId
  }

  private onPop(fromId?: string, toId?: string) {
    this.popRouter(fromId)
    DialogProxy.instance.navigatorObserve.curRouter = toId
  }

  private onReplace(fromId?: string, toId?: string) {
    this.popRouter(fromId)
    DialogProxy.instance.navigatorObserve.curRouter = toId
  }

  private getNavId(info: NavDestinationInfo | NavBar): string | undefined {
    let pushNavId: string | undefined = undefined
    if (typeof info === 'string') {
      pushNavId = 'navBar'
    } else {
      pushNavId = (info as NavDestinationInfo).navDestinationId
    }
    return pushNavId
  }

  // 某一个路由走到了pop,那就隐藏这路由关联的兑换框并删除
  private popRouter(popRouter: string | undefined) {
    DialogProxy.instance.dialogList.filter((item) => {
      let isAccess = item.bindRouter !== popRouter
      if (!isAccess) {
        item.remove()
      }
      return isAccess
    })

    this.backgroundRouterIdSet.delete(popRouter)
  }

  // 路由状态变化，要判断非当前路由的对话框都隐藏掉
  private updateDialogVisibleState() {
    DialogProxy.instance.dialogList.forEach((item) => {
      if (this.backgroundRouterIdSet.has(item.bindRouter)) {
        item.visible = DialogProxy.instance.navigatorObserve.curRouter === item.bindRouter
      } else {
        item.visible = true
      }
    })
  }
}