import { BuilderNode, FrameNode, NodeController } from '@kit.ArkUI';
import { SmartDialogController } from '../helper/SmartDialogController';

export class DialogNodeController extends NodeController {
  rootNode: BuilderNode<[Object]> | null = null
  wrapBuilder?: WrappedBuilder<[Object]>
  param?: Object

  constructor(wrapBuilder?: WrappedBuilder<[Object]>, param?: Object, controller?: SmartDialogController) {
    super()
    this.wrapBuilder = wrapBuilder
    this.param = param
    controller?.setListener((args: Object) => {
      this.rootNode?.update(args)
    })
  }

  makeNode(uiContext: UIContext): FrameNode | null {
    if (this.rootNode == null) {
      this.rootNode = new BuilderNode(uiContext);
      this.rootNode.build(this.wrapBuilder, this.param)
    }
    return this.rootNode.getFrameNode();
  }
}