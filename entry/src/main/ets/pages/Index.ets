import { OhosSmartDialog, SmartDialog, SmartDialogController } from 'ohos_smart_dialog';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Stack() {
      Button("MainPage")
        .backgroundColor(Color.Orange)
        .onClick(() => {
          let controller = new SmartDialogController()
          SmartDialog.show({
            wrapBuilder: wrapBuilder(buttonText),
            wrapBuilderArgs: { msg: 0, controller: controller } as Model,
            controller: controller,
          })
        })

      OhosSmartDialog()
    }.height('100%').width('100%')
  }
}


@Builder
function buttonText(params: Model) {
  Text(params.msg.toString())
    .fontSize(30)
    .padding(50)
    .backgroundColor(getRandomColor())
    .onClick(() => {
      // params.msg += 1
      // params.controller?.refresh(params)
      SmartDialog.show({
        wrapBuilder: wrapBuilder(buttonText),
        wrapBuilderArgs: { msg: 2 } as Model,
      })
    })
}

export class Model {
  msg: number = 0
  controller ?: SmartDialogController
}


function getRandomColor(): string {
  const letters: string = '0123456789ABCDEF';
  let color = '#';
  for (let i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}