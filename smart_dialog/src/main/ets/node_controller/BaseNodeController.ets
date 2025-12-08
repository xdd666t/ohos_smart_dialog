import { ComponentContent, FrameNode, NodeController, typeNode } from '@kit.ArkUI'
import { BaseDialogModel } from '../model/BaseDialogModel'


export class BaseNodeController extends NodeController {
  public rootNode: FrameNode | null = null
  private uiContext: UIContext | null = null

  makeNode(uiContext: UIContext): FrameNode | null {
    this.uiContext = uiContext
    if (this.rootNode == null) {
      this.rootNode = typeNode.createNode(this.uiContext, 'Stack')
    }

    return this.rootNode
  }

  inset(model: BaseDialogModel, wrapBuilder: WrappedBuilder<[ESObject]>, sibling?: FrameNode | null) {
    if (this.uiContext === null || this.rootNode === null) {
      return
    }
    const stack = typeNode.createNode(this.uiContext, 'Stack')
    stack.addComponentContent(new ComponentContent<ESObject>(this.uiContext, wrapBuilder, model))
    stack.initialize().hitTestBehavior(HitTestMode.Transparent)

    if (sibling) {
      this.rootNode.insertChildAfter(stack, sibling)
    } else {
      this.rootNode.appendChild(stack)
    }
    model.builderNode = stack
  }

  remove(model: BaseDialogModel) {
    if (this.rootNode === null) {
      return
    }

    const frameNode = model.builderNode
    this.rootNode.removeChild(frameNode)
    frameNode?.disposeTree()
  }
}
