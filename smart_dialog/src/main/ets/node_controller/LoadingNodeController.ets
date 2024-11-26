import { LoadingDialogModel } from '../dialog/loading/LoadingDialogModel'
import { LoadingDialogComponent } from '../dialog/loading/LoadingDialogComponent'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { BaseNodeController } from './BaseNodeController'
import { SmartDialog } from '../SmartDialog'
import { SmartAllDialogType } from '../config/EnumConfig'
import { DialogProxy } from '../helper/DialogProxy'
import { MaskComponent } from '../dialog/MaskComponent'
import { GestureComponent } from '../component/GestureComponent'

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
      animation.maskOpacity = 1
    }
    loadingDialog.remove()
    this.inset(loadingDialog)
  }
}

@Builder
function buildLoadingNode(item: LoadingDialogModel) {
  LoadingNode({ item: item })
}

@Component
struct LoadingNode {
  item: LoadingDialogModel = new LoadingDialogModel()

  build() {
    GestureComponent({ useDefaultGesture: !this.item.usePenetrate }) {
      Stack() {
        MaskComponent({ item: this.item })

        LoadingDialogComponent({
          item: this.item,
          builder: this.item.builder
        })
      }
    }
  }
}
