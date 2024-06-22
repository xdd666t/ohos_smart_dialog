import { BuilderNode, FrameNode, NodeController } from '@kit.ArkUI'
import { DialogModel } from '../config/model/DialogModel'
import { MainComponent } from './MainComponent'
import { MaskComponent } from './MaskComponent'

// export class DialogNodeController extends NodeController {
//   rootNode: BuilderNode<[Object]> | null = null
//   wrapBuilder?: WrappedBuilder<[Object]>
//   param?: Object
//
//   constructor(wrapBuilder?: WrappedBuilder<[Object]>, param?: Object, controller?: SmartDialogController) {
//     super()
//     this.wrapBuilder = wrapBuilder
//     this.param = param
//     controller?.setListener((args: Object) => {
//       this.rootNode?.update(args)
//     })
//   }
//
//   makeNode(uiContext: UIContext): FrameNode | null {
//     if (this.rootNode == null) {
//       this.rootNode = new BuilderNode(uiContext)
//       this.rootNode.build(this.wrapBuilder, this.param)
//     }
//     return this.rootNode.getFrameNode()
//   }
// }

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

  inset(model: DialogModel) {
    if (this.uiContext === null || this.rootNode === null) {
      return
    }

    let builderNode = new BuilderNode(this.uiContext)
    builderNode.build(wrapBuilder<[ESObject]>(buildSmartNode), model)
    this.rootNode.appendChild(builderNode.getFrameNode())

    model.builderNode = builderNode
  }

  remove(model: DialogModel) {
    if (this.rootNode === null) {
      return
    }

    this.rootNode.removeChild(model.builderNode?.getFrameNode())
  }
}


@Builder
function buildSmartNode(item: DialogModel) {
  SmartNode({ item: item })
}

@Component
struct SmartNode {
  item: DialogModel = new DialogModel()

  build() {
    Stack({ alignContent: this.item.alignment }) {
      MaskComponent({ item: this.item })

      MainComponent({ item: this.item })
    }.visibility(this.item.visible === true ? Visibility.Visible : Visibility.None)
  }
}
