/**
 * @className: DialogNavigatorObserver
 * @author: Hide Name
 * @description:
 * @create: 2024-09-23 15:57
 */
import { DialogProxy } from './DialogProxy'

const TAG = "DialogNavigatorObserver"

export class DialogNavigatorObserver {
  private static readonly ROOT_PAGE_ID = 'navBar'
  curRouter: string = DialogNavigatorObserver.ROOT_PAGE_ID
  private backgroundRouterIdSet = new Set<string | undefined>()

  public onPush(from: NavDestinationInfo | NavBar, to: NavDestinationInfo | NavBar) {
    console.log(`onPush from=${JSON.stringify(from)},to=${JSON.stringify(to)}`, TAG)
    let fromId: string = this.getNavId(from) ?? ""
    let toId: string = this.getNavId(to) ?? ""
    this.curRouter = toId
    this.backgroundRouterIdSet.add(fromId)
    console.log(`onPush from_id_${fromId},to_id_${toId}`, TAG)
    this.updateDialogVisibleState()
  }

  public onPop(from: NavDestinationInfo | NavBar, to: NavDestinationInfo | NavBar) {
    console.log(`onPop from=${JSON.stringify(from)},to=${JSON.stringify(to)}`, TAG)
    let fromId: string = this.getNavId(from) ?? ""
    let toId: string = this.getNavId(to) ?? ""
    this.popRouter(fromId)
    this.curRouter = toId
    console.log(`onPop from_id_${fromId},to_id_${toId}`, TAG)
    this.updateDialogVisibleState()
  }

  public onReplace(from: NavDestinationInfo | NavBar, to: NavDestinationInfo | NavBar) {
    console.log(`onReplace from=${JSON.stringify(from)},to=${JSON.stringify(to)}`, TAG)
    let fromId: string = this.getNavId(from) ?? ""
    let toId: string = this.getNavId(to) ?? ""
    this.popRouter(fromId)
    this.curRouter = toId
    console.log(`onReplace from_id_${fromId},to_id_${toId}`, TAG)
    this.updateDialogVisibleState()
  }

  private getNavId(info: NavDestinationInfo | NavBar): string | undefined {
    let pushNavId: string | undefined = undefined
    if (typeof info === 'string') {
      pushNavId = DialogNavigatorObserver.ROOT_PAGE_ID
    } else {
      pushNavId = (info as NavDestinationInfo).navDestinationId
    }
    return pushNavId
  }

  /**
   * 某一个路由走到了pop,那就隐藏这路由关联的兑换框并删除
   * @param popRouter
   */
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

  /**
   * 路由状态变化，要判断非当前路由的对话框都隐藏掉
   */
  private updateDialogVisibleState() {
    DialogProxy.instance.dialogList.forEach((item) => {
      if (this.backgroundRouterIdSet.has(item.bindRouter)) {
        item.visible = this.curRouter === item.bindRouter
      } else {
        item.visible = true
      }
    })
  }
}