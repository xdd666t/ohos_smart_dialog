import { DialogProxy } from '../dialog_proxy/DialogProxy'

export default class SmartNavigatorObserver implements NavigationInterception {
  private static defaultRouter: string = "index"
  static curRouter: string = SmartNavigatorObserver.defaultRouter
  private lastAllPathName: Array<string> = []
  // 开始显示
  willShow?: InterceptionShowCallback = (from, to, operation, isAnimated) => {
    let allPathName = DialogProxy.instance.navPathStack.getAllPathName()
    let curRouter = SmartNavigatorObserver.defaultRouter
    if (allPathName.length > 0) {
      curRouter = allPathName[allPathName.length - 1]
    }
    SmartNavigatorObserver.curRouter = curRouter

    this.processPush(allPathName)
    this.processPop(allPathName)
    this.refresh()

    this.lastAllPathName = JSON.parse(JSON.stringify(allPathName))
  }
  //结束显示
  didShow?: InterceptionShowCallback = (from, to, operation, isAnimated) => {
  }

  processPush(allPathName: Array<string>) {
    if (this.lastAllPathName.length > allPathName.length) {
      return
    }
    let pushRouter = ""
    if (allPathName.length > 0) {
      pushRouter = allPathName[allPathName.length -1]
    }
  }

  processPop(allPathName: Array<string>) {
    if (this.lastAllPathName.length < allPathName.length) {
      return
    }
    let popRouter = ""
    if (this.lastAllPathName.length > 0) {
      popRouter = this.lastAllPathName[this.lastAllPathName.length -1]
    }
    DialogProxy.instance.dialogProxyState.originDialogList.filter((item) => item.routerName !== popRouter)
  }

  refresh() {
    DialogProxy.instance.dialogProxyState.dialogList.forEach((item) => {
      item.visible = SmartNavigatorObserver.curRouter === item.routerName
    })
    DialogProxy.instance.requestLayout()
  }
}
