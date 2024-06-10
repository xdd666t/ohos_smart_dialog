export class SmartDialogController {
  private callback?: (args: Object) => void

  refresh(args: Object) {
    this.callback?.(args)
  }

  setListener(callBack?: (args: Object) => void) {
    this.callback = callBack
  }

  removeListener() {
    this.callback = undefined
  }
}
