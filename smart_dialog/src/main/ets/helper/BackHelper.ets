import { SmartDialog } from '../SmartDialog'

export class BackHelper {
  private static _instance?: BackHelper

  private constructor() {
  }

  static get instance() {
    return BackHelper._instance ? BackHelper._instance : BackHelper._instance = new BackHelper()
  }


  onBackPressed(): boolean {
    if (SmartDialog.config.checkExist()) {
      SmartDialog.dismiss()
      return true
    }

    return false
  }

  onBackPressedDialog(): boolean {
    return false
  }
}