import { AttachDialogModel } from '../dialog/attach/AttachDialogModel'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { CustomDialogModel } from '../dialog/custom/CustomDialogModel'
import { AttachDialogComponent } from '../dialog/attach/AttachDialogComponent'
import { CustomDialogComponent } from '../dialog/custom/CustomDialogComponent'

import { MaskComponent } from '../dialog/MaskComponent'
import { BaseNodeController } from './BaseNodeController'
import { DialogProxy } from '../helper/DialogProxy'
import { FrameNode } from '@kit.ArkUI'
import { GestureComponent } from '../component/GestureComponent'

export class DialogNodeController extends BaseNodeController {
  inset(model: BaseDialogModel) {
    super.inset(model, wrapBuilder<[ESObject]>(buildSmartNode))
  }

  insertChildAfter(model: BaseDialogModel, sibling?: FrameNode | null) {
    super.inset(model, wrapBuilder<[ESObject]>(buildSmartNode), sibling)
  }

  update(currentDialog: BaseDialogModel) {
    const dialogProxy = DialogProxy.instance
    const dialogList = dialogProxy.dialogList
    const targetIndex = dialogList.findIndex((value: BaseDialogModel) => {
      return value.tag === currentDialog.tag
    })
    if (targetIndex !== -1) {
      const targetDialog = dialogList[targetIndex]
      currentDialog.animation.maskStartTime = 0
      currentDialog.animation.maskOpacity = 1
      this.insertChildAfter(currentDialog, targetDialog.builderNode?.getFrameNode())
      // 移除之前的node
      dialogProxy.dialogNodeController.remove(targetDialog)
      // 置换模板弹窗栈中的数据
      dialogList[targetIndex] = currentDialog
    } else {
      dialogProxy.dialogNodeController.inset(currentDialog)
      dialogList.push(currentDialog)
    }
  }
}


@Builder
function buildSmartNode(item: BaseDialogModel) {
  SmartNode({ item: item })
}

@Component
struct SmartNode {
  item: BaseDialogModel = new BaseDialogModel()

  build() {
    GestureComponent({ useDefaultGesture: !this.item.usePenetrate }) {
      Stack({ alignContent: this.item.alignment }) {
        MaskComponent({ item: this.item })

        if (this.item instanceof CustomDialogModel) {
          CustomDialogComponent({ item: this.item })
        } else if (this.item instanceof AttachDialogModel) {
          AttachDialogComponent({ item: this.item })
        }
      }.visibility(this.item.visible ? Visibility.Visible : Visibility.None)
    }
  }
}
