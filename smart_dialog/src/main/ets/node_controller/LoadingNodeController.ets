import { LoadingDialogModel } from '../component/loading_dialog/LoadingDialogModel'
import { LoadingDialogComponent } from '../component/loading_dialog/LoadingDialogComponent'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { BaseNodeController } from './BaseNodeController'
import { SmartDialog } from '../SmartDialog'
import { SmartAllDialogType } from '../config/EnumConfig'

export class LoadingNodeController extends BaseNodeController {
  inset(model: BaseDialogModel) {
    super.inset(model, wrapBuilder<[ESObject]>(buildLoadingNode))
  }

  clearChildren() {
    this.rootNode?.clearChildren()
  }

  update(loadingDialog?: LoadingDialogModel) {
    if (!loadingDialog) {
      return
    }

    if (SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.loading] })) {
      loadingDialog.animation.startTime = 0
    }
    this.clearChildren()
    this.inset(loadingDialog)
  }
}

@Builder
function buildLoadingNode(loadingDialog: LoadingDialogModel) {
  LoadingNode({ loadingDialog: loadingDialog })
}

@Component
struct LoadingNode {
  loadingDialog: LoadingDialogModel = new LoadingDialogModel()

  build() {
    LoadingDialogComponent({ item: this.loadingDialog })
  }
}