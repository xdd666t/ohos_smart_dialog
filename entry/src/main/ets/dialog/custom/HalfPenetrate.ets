import { SmartDialog } from 'ohos_smart_dialog'
import { randomColor } from '../../app/kit/Color'

export function customHalfPenetrate() {
  SmartDialog.show({
    builder: dialogUsePenetrate,
    usePenetrate: true,
    maskBuilder: halfMask,
  })
}

@Builder
function dialogUsePenetrate() {
  Text(`透明遮罩事件穿透, 非透明遮罩事件不穿透`).fontColor(Color.White).padding(50)
    .borderRadius(12)
    .backgroundColor(randomColor())
}

@Builder
function halfMask() {
  Stack() {
    Stack()
      .backgroundColor(Color.Brown)
      .width("100%")
      .height("100%")
      .opacity(0.5)
      .gesture(GestureGroup(GestureMode.Exclusive,
        TapGesture(),
        LongPressGesture(),
        PanGesture(),
        PinchGesture(),
        SwipeGesture(),
        RotationGesture(),
      ))
  }.margin({ top: 200 })
}