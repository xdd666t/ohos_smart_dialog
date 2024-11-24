import { SmartDialog } from 'ohos_smart_dialog'
import { delay } from 'ohos_smart_dialog/src/main/ets/kit/function'
import { randomColor } from '../../app/kit/Color'

export function attachLocation() {
  SmartDialog.show({
    builder: dialog
  })
}

class AttachLocation {
  title: string = ""
  alignment?: Alignment
}

const locationList: Array<AttachLocation> = [
  { title: "TopStart", alignment: Alignment.TopStart },
  { title: "Top", alignment: Alignment.Top },
  { title: "TopEnd", alignment: Alignment.TopEnd },
  { title: "Start", alignment: Alignment.Start },
  { title: "Center", alignment: Alignment.Center },
  { title: "End", alignment: Alignment.End },
  { title: "BottomStart", alignment: Alignment.BottomStart },
  { title: "Bottom", alignment: Alignment.Bottom },
  { title: "BottomEnd", alignment: Alignment.BottomEnd },
]

@Builder
function dialog() {
  Column() {
    Grid() {
      ForEach(locationList, (item: AttachLocation) => {
        GridItem() {
          buildButton(item.title, () => {
            SmartDialog.showAttach({
              targetId: item.title,
              alignment: item.alignment,
              maskColor: Color.Transparent,
              builder: targetLocationDialog
            })
          })
        }
      })
    }.columnsTemplate('1fr 1fr 1fr').height(220)

    buildButton("allOpen", async () => {
      for (let index = 0; index < locationList.length; index++) {
        let item = locationList[index]
        SmartDialog.showAttach({
          targetId: item.title,
          alignment: item.alignment,
          maskColor: Color.Transparent,
          builder: targetLocationDialog,
        })
        await delay(300)
      }
    }, randomColor())
  }
  .borderRadius(12)
  .width(700)
  .padding(30)
  .backgroundColor(Color.White)
}

@Builder
function buildButton(title: string, onClick?: VoidCallback, bgColor?: ResourceColor) {
  Text(title)
    .backgroundColor(bgColor ?? "#4169E1")
    .constraintSize({ minWidth: 120, minHeight: 46 })
    .margin(10)
    .textAlign(TextAlign.Center)
    .fontColor(Color.White)
    .borderRadius(5)
    .onClick(onClick)
    .id(title)
}

@Builder
function targetLocationDialog() {
  Text("targetIdDialog")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(35)
    .borderRadius(12)
    .backgroundColor(randomColor())
}