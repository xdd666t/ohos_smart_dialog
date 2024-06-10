# ohos_smart_dialog
相对鸿蒙的弹窗（AlertDialog，CustomDialog，SubWindow）SmartDialog的优越性
- 支持连续打开多弹窗，支持指定关闭弹窗
- 支持在非UI区域调用
- 优雅且简单的使用方式
- 强大的参数定义
- 各种开箱即用的功能
# 初始化

```dart
@Entry  
@Component  
struct Index {  
  @State message: string = 'Hello World';  
  
  build() {  
    Stack() {  
      MainPage()  
  
      // here  
      OhosSmartDialog()  
    }.height('100%').width('100%')  
  }  
}
```
# 使用
- 打开弹窗
    - 请注意: wrapBuilderArgs的传参必须是一个实体类，传基础类型会导致弹窗不生效
    - 你在弹窗中操作的数据，都应该保存在你传入wrapBuilderArgs参数的对象中
    - 因为鸿蒙的特殊性，打开多弹窗会刷新之前的弹窗，所有数据的展现，会以wrapBuilderArgs传入的对象数据为基准
```dart
@Entry  
@Component  
struct Index {  
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
    }.height('100%').width('100%')  
  }  
}
  
  
@Builder  
function buttonText(params: Model) {  
  Text(params.msg.toString())  
	.fontSize(30)  
	.padding(50)
    .backgroundColor(Color.Orange)  
    .onClick(() => {  
	params.msg += 1  
	params.controller?.refresh(params)
    })  
}  
  
class Model {  
  msg: number = 0  
  controller?: SmartDialogController  
}
```
- 关闭弹窗
```dsart
SmartDialog.dismmiss()
```
