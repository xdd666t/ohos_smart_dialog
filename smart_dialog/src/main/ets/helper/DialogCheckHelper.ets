import { CheckExistOption } from '../config/model/CheckExistOption'
import { dialogProxy } from '../dialog_proxy/DialogProxy'

export class DialogCheckHelper {
  private static _instance?: DialogCheckHelper

  private constructor() {
  }

  static get instance() {
    return DialogCheckHelper._instance ? DialogCheckHelper._instance :
      DialogCheckHelper._instance = new DialogCheckHelper()
  }

  checkExist(option?: CheckExistOption): boolean {
    let dialogList = dialogProxy.dialogList

    let exist = false
    dialogList.forEach((item) => {
      if (item.visible) {
        exist = true
      }
    })
    return exist
  }
}