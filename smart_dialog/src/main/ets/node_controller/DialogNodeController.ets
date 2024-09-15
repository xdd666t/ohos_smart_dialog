import { BuilderNode, FrameNode, NodeController } from '@kit.ArkUI'
import { AttachDialogModel } from '../component/attach_dialog/AttachDialogModel'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { CustomDialogModel } from '../component/custom_dialog/CustomDialogModel'
import { AttachDialogComponent } from '../component/attach_dialog/AttachDialogComponent'
import { CustomDialogComponent } from '../component/custom_dialog/CustomDialogComponent'

import { MaskComponent } from '../component/MaskComponent'
import { BaseNodeController } from './BaseNodeController'

export class DialogNodeController extends BaseNodeController {
  inset(model: BaseDialogModel) {
    super.inset(model, wrapBuilder<[ESObject]>(buildSmartNode))
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
    Stack({ alignContent: this.item.alignment }) {
      MaskComponent({ item: this.item })

      if (this.item instanceof CustomDialogModel) {
        CustomDialogComponent({ item: this.item })
      } else if (this.item instanceof AttachDialogModel) {
        AttachDialogComponent({ item: this.item })
      }
    }
    .visibility(this.item.visible ? Visibility.Visible : Visibility.None)
  }
}
