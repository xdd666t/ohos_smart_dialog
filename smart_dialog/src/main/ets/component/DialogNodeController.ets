import { BuilderNode, FrameNode, NodeController } from '@kit.ArkUI'
import { AttachDialogModel } from './attach_dialog/AttachDialogModel'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { CustomDialogModel } from './custom_dialog/CustomDialogModel'
import { AttachDialogComponent } from './attach_dialog/AttachDialogComponent'
import { CustomDialogComponent } from './custom_dialog/CustomDialogComponent'

import { MaskComponent } from './MaskComponent'

export class DialogNodeController extends NodeController {
  public rootNode: FrameNode | null = null
  private uiContext: UIContext | null = null

  makeNode(uiContext: UIContext): FrameNode | null {
    this.uiContext = uiContext
    if (this.rootNode == null) {
      this.rootNode = new FrameNode(uiContext)
    }

    return this.rootNode
  }

  inset(model: BaseDialogModel) {
    if (this.uiContext === null || this.rootNode === null) {
      return
    }

    let builderNode = new BuilderNode(this.uiContext)
    builderNode.build(wrapBuilder<[ESObject]>(buildSmartNode), model)
    this.rootNode.appendChild(builderNode.getFrameNode())

    model.builderNode = builderNode
  }

  remove(model: BaseDialogModel) {
    if (this.rootNode === null) {
      return
    }

    this.rootNode.removeChild(model.builderNode?.getFrameNode())
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
    }.visibility(this.item.visible ? Visibility.Visible : Visibility.None)
  }
}
