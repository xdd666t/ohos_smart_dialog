import { SmartDialog } from '../SmartDialog'

export class BackHelper {
  private static _instance?: BackHelper

  private constructor() {
  }

  static get instance() {
    return BackHelper._instance ? BackHelper._instance : BackHelper._instance = new BackHelper()
  }


  onBackPressed(onBack?: () => boolean): () => boolean {
    return () => {
      if (SmartDialog.checkExist()) {
        SmartDialog.dismiss()
        return true
      }

      return onBack?.() ?? false
    }
  }

  onBackPressedDialog(): boolean {
    return false
  }
}