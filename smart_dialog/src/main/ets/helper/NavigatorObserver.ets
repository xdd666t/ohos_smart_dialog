import { DialogProxy } from './DialogProxy'
import { uiObserver } from '@kit.ArkUI'

/**
 * @className: DialogNavigatorObserver
 * @author: Hide Name
 * @create: 2024-09-23 15:57
 */
export class NavigatorObserver {
  private defaultRouter = 'navBar'
  private backgroundRouterIdSet = new Set<string | undefined>()
  curRouter?: string = this.defaultRouter

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
    DialogProxy.instance.navigatorObserve.curRouter = toId
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
    // console.info(`DialogNavigatorObserver:fromId:${fromId}:toId:${toId}`)
    // console.info(`DialogNavigatorObserver:${JSON.stringify(info)}`)
  }

  private onPush(fromId?: string, _toId?: string) {
    this.backgroundRouterIdSet.add(fromId)
  }

  private onPop(fromId?: string, toId?: string) {
    this.removeTargetRouter(fromId)
    this.popRouter(toId)
  }

  private onReplace(fromId?: string, _toId?: string) {
    this.removeTargetRouter(fromId)
  }

  private getNavId(info: NavDestinationInfo | NavBar): string | undefined {
    let pushNavId: string | undefined = undefined
    if (typeof info === 'string') {
      pushNavId = this.defaultRouter
    } else {
      pushNavId = (info as NavDestinationInfo).navDestinationId
    }
    return pushNavId
  }

  // 移除指定路由
  private removeTargetRouter(targetId: string | undefined) {
    const dialogProxy = DialogProxy.instance
    dialogProxy.dialogList = dialogProxy.dialogList.filter((item) => {
      const isAccess = (item.bindRouter !== targetId)
      if (!isAccess) {
        item.remove()
        this.backgroundRouterIdSet.delete(item.bindRouter)
      }
      return isAccess
    })
  }

  // 某一个路由走到了pop,需要将路由关联的弹窗删除
  private popRouter(toId: string | undefined) {
    const dialogProxy = DialogProxy.instance
    // 兼容pop多个路由场景
    try {
      if (toId == undefined) {
        return
      }
      const toIdNum = this.parseNum(toId)
      dialogProxy.dialogList = dialogProxy.dialogList.filter((item) => {
        const bindRouter = item.bindRouter
        const bindRouterNum = this.parseNum(bindRouter)
        const isAccess = (bindRouterNum <= toIdNum)
        if (!isAccess) {
          item.remove()
          this.backgroundRouterIdSet.delete(bindRouter)
        }
        return isAccess
      })
    } catch (error) {
    }
  }

  private parseNum(value: string | undefined): number {
    try {
      if (value === this.defaultRouter) {
        return -1
      }
      const valueNum = parseInt(value ?? "-1")
      return isNaN(valueNum) ? -1 : valueNum
    } catch (error) {
      return -1
    }
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