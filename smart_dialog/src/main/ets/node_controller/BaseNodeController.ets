import { BuilderNode, FrameNode, NodeController } from '@kit.ArkUI'
import { BaseDialogModel } from '../model/BaseDialogModel'


export class BaseNodeController extends NodeController {
  public rootNode: FrameNode | null = null
  private uiContext: UIContext | null = null

  makeNode(uiContext: UIContext): FrameNode | null {
    this.uiContext = uiContext
    if (this.rootNode == null) {
      this.rootNode = new FrameNode(uiContext)
    }

    return this.rootNode
  }

  inset(model: BaseDialogModel, wrapBuilder: WrappedBuilder<[ESObject]>) {
    if (this.uiContext === null || this.rootNode === null) {
      return
    }

    let builderNode = new BuilderNode(this.uiContext)
    builderNode.build(wrapBuilder, model)
    this.rootNode.appendChild(builderNode.getFrameNode())

    model.builderNode = builderNode
  }

  remove(model: BaseDialogModel) {
    if (this.rootNode === null) {
      return
    }

    const frameNode = model.builderNode?.getFrameNode()
    this.rootNode.removeChild(frameNode)
    frameNode?.disposeTree()
  }
}
