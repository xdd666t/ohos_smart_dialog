import { LoadingDialogModel } from '../component/loading_dialog/LoadingDialogModel'
import { LoadingDialogComponent } from '../component/loading_dialog/LoadingDialogComponent'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { BaseNodeController } from './BaseNodeController'
import { SmartDialog } from '../SmartDialog'
import { SmartAllDialogType } from '../config/EnumConfig'
import { DialogProxy } from '../helper/DialogProxy'
import { MaskComponent } from '../component/MaskComponent'

export class LoadingNodeController extends BaseNodeController {
  inset(model: BaseDialogModel) {
    super.inset(model, wrapBuilder<[ESObject]>(buildLoadingNode))
  }

  clearChildren() {
    DialogProxy.instance.loadingDialog.builderNode?.getFrameNode()?.disposeTree()
    this.rootNode?.clearChildren()
  }

  update(loadingDialog: LoadingDialogModel) {
    if (!loadingDialog) {
      return
    }

    if (SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })) {
      const animation = loadingDialog.animation
      animation.dialogStartTime = 0
      animation.maskStartTime = 0
    }
    loadingDialog.remove()
    this.inset(loadingDialog)
  }
}

@Builder
function buildLoadingNode(loadingDialog: LoadingDialogModel) {
  Stack() {
    MaskComponent({ item: loadingDialog })

    LoadingDialogComponent({
      item: loadingDialog,
      builder: loadingDialog.builder
    })
  }
}