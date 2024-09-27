import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function customUseArgs() {
  SmartDialog.show({
    builder: dialogArgs,
    // 支持任何类型
    builderArgs: Math.random(),
  })
}

@Builder
function dialogArgs(args: number) {
  Stack() {
    Text(`D`)
      .fontColor(Color.White)
      .padding(50)
      .borderRadius(12)
      .backgroundColor(randomColor())
      .onTouch(() => {
        console.log("dialogArgs:D");
      })

    Stack() {
      Stack() {
        Text(`A`)
          .fontColor(Color.White)
          .padding(50)
          .borderRadius(12)
          .backgroundColor(randomColor())
          .hitTestBehavior(HitTestMode.Transparent)
          .onTouch((e) => {
            console.log("dialogArgs:A");
          })
      }
      .hitTestBehavior(HitTestMode.Transparent)
      .onTouch((e) => {
        // e.stopPropagation()
        console.log("dialogArgs:B");
      })
    }
    .hitTestBehavior(HitTestMode.Transparent)
    .onTouch((e) => {
      console.log("dialogArgs:C");
    })
  }
  .onTouch(() => {
    console.log("dialogArgs:E");
  })
}