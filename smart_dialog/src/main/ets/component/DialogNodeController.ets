import { BuilderNode, FrameNode, NodeController } from '@kit.ArkUI'
import { AttachDialogModel } from '../model/AttachDialogModel'
import { BaseDialogModel } from '../model/BaseDialogModel'
import { CustomDialogModel } from '../model/CustomDialogModel'
import { AttachDialogComponent } from './AttachDialogComponent'
import { CustomDialogComponent } from './CustomDialogComponent'

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

    const frameNode = model.builderNode?.getFrameNode()
    frameNode?.disposeTree()
    this.rootNode.removeChild(frameNode)
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
    }.visibility(this.item.visible === true ? Visibility.Visible : Visibility.None)
  }
}
