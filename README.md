[![ohos_smart_dialog](https://img.shields.io/badge/ohpm-ohos_smart_dialog-4169E1)](https://ohpm.openharmony.cn/#/cn/detail/ohos_smart_dialog)  [![stars](https://img.shields.io/github/stars/xdd666t/ohos_smart_dialog?logo=github)](https://github.com/xdd666t/ohos_smart_dialog)  [![issues](https://img.shields.io/github/issues/xdd666t/ohos_smart_dialog?logo=github)](https://github.com/xdd666t/ohos_smart_dialog/issues) [![commit](https://img.shields.io/github/last-commit/xdd666t/ohos_smart_dialog?logo=github)](https://github.com/xdd666t/ohos_smart_dialog/commits)

**强大的SmartDialog**

- 单次初始化后即可使用，无需多处配置相关Component
- 优雅，极简的用法
- 非UI区域内使用，自定义Component
- 返回事件处理，优化的跨页面交互
- 多弹窗能力，多位置弹窗：上下左右中间
- 定位弹窗：自动定位目标Component
- 极简用法的loading弹窗

鸿蒙版本的SmartDialog，功能会逐步和 [flutter_smart_dialog](https://github.com/fluttercandies/flutter_smart_dialog) 对齐（长期），api会尽量保持一致

但凡用过鸿蒙原生弹窗，就能体会到有多么难用和奇葩，我就不吐槽了！！！实在受不了，就把鸿蒙版的SmartDialog写出来了，由于鸿蒙api的设计和相关限制，用法和相关初始化都有一定程度的妥协。

# 效果

- Tablet 模拟器目前有些问题，会导致动画闪烁，请忽略；注：真机动画丝滑流畅，无任何问题

![attachLocation](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202406231725613.gif)

![customTag](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102228252.gif)

![customJumpPage](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202406231725830.gif)

# 极简用法

```typescript
// dialog
SmartDialog.show({
  builder: dialogArgs,
  builderArgs: Math.random(),
})

@Builder
function dialogArgs(args: number) {
  Text(args.toString()).padding(50).backgroundColor(Color.White)
}

// loading
SmartDialog.showLoading()
```

# 安装

- github：https://github.com/xdd666t/ohos_smart_dialog
- ohos：https://ohpm.openharmony.cn/#/cn/detail/ohos_smart_dialog

```typescript
ohpm install ohos_smart_dialog 
```

# 配置

## 初始化

**配置完下述的初始化操作后，你将可以在任何地方使用弹窗，没有任何限制**

- 注：内部已使用无感路由注册，外部无需手动处理

```typescript
@Entry
@Component
struct Index {
  navPathStack: NavPathStack = new NavPathStack()

  build() {
    Stack() {
      Navigation(this.navPathStack) {
        MainPage()
      }
      .mode(NavigationMode.Stack)
      .hideTitleBar(true)
      .navDestination(pageMap)

      // here dialog init
      OhosSmartDialog()
    }.height('100%').width('100%')
  }
}
```

## 返回事件监听

> 别问我为啥返回事件的监听，处理的这么不优雅，鸿蒙里面没找全局返回事件监听，我也没辙。。。

- 如果你无需处理返回事件，可以使用下述写法

```typescript
// Entry页面处理
@Entry
@Component
struct Index {
  onBackPress(): boolean | void {
    return OhosSmartDialog.onBackPressed()()
  }
}

// 路由子页面
struct JumpPage {
  build() {
    NavDestination() {
      // ....
    }
    .onBackPressed(OhosSmartDialog.onBackPressed())
  }
}
```

- 如果你需要处理返回事件，在OhosSmartDialog.onBackPressed()中传入你的方法即可

```typescript
// Entry页面处理
@Entry
@Component
struct Index {
  onBackPress(): boolean | void {
    return OhosSmartDialog.onBackPressed(this.onCustomBackPress)()
  }

  onCustomBackPress(): boolean {
    return false
  }
}

// 路由子页面
@Component
struct JumpPage {
  build() {
    NavDestination() {
      // ...
    }
    .onBackPressed(OhosSmartDialog.onBackPressed(this.onCustomBackPress))
  }

  onCustomBackPress(): boolean {
    return false
  }
}
```

## 适配暗黑模式

- 为了极致的体验，深色模式切换时，打开态弹窗也应刷新为对应模式的样式，故需要进行下述配置

```typescript
export default class EntryAbility extends UIAbility {  
  onConfigurationUpdate(newConfig: Configuration): void {  
    OhosSmartDialog.onConfigurationUpdate(newConfig)  
  }  
}
```

# 配置全局默认样式

- showLoading自定样式十分简单

```typescript
SmartDialog.showLoading({ builder: customLoading })
```

**但是对于大家来说，肯定是想用`SmartDialog.showLoading()`这种简单写法，估支持自定义全局默认样式**

- 需要在OhosSmartDialog上配置自定义的全局默认样式

```typescript
@Entry
@Component
struct Index {
  build() {
    Stack() {
      OhosSmartDialog({
        // custom global loading
        loadingBuilder: customLoading,
      })
    }.height('100%').width('100%')
  }
}

@Builder
export function customLoading(args: ESObject) {
  LoadingProgress().width(80).height(80).color(Color.White)
}
```

- 配置完你的自定样式后，使用下述代码，就会显示你的loading样式

```typescript
SmartDialog.showLoading()

// 支持入参，可以在特殊场景下灵活配置
SSmartDialog.showLoading({ builderArgs: 1 })
```

# SmartConfig

- 支持全局配置弹窗的默认属性

```typescript
function init() {
  // show
  SmartDialog.config.custom.maskColor = "#75000000"
  SmartDialog.config.custom.alignment = Alignment.Center

  // showAttach
  SmartDialog.config.attach.attachAlignmentType = SmartAttachAlignmentType.center
}
```

- 检查弹窗是否存在

```typescript
// 检查当前是否有CustomDialog，AttachDialog或LoadingDialog处于打开状态
let isExist = SmartDialog.checkExist()

// 检查当前是否有AttachDialog处于打开状态
let isExist = SmartDialog.checkExist({ dialogTypes: [SmartAllDialogType.attach] })

// 检查当前是否有tag为“xxx”的dialog处于打开状态
let isExist = SmartDialog.checkExist({ tag: "xxx" })
```

# CustomDialog

- 下方会共用的方法

```typescript
export function randomColor(): string {
  const letters: string = '0123456789ABCDEF';
  let color = '#';
  for (let i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}

export function delay(ms?: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}
```

## 传参弹窗

```typescript
export function customUseArgs() {
  SmartDialog.show({
    builder: dialogArgs,
    // 支持任何类型
    builderArgs: Math.random(),
  })
}

@Builder
function dialogArgs(args: number) {
  Text(`${args}`).fontColor(Color.White).padding(50)
    .borderRadius(12).backgroundColor(randomColor())
}
```

![customUseArgs](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102227942.gif)

## 多位置弹窗

```typescript
export async function customLocation() {
  const animationTime = 1000
  SmartDialog.show({
    builder: dialogLocationHorizontal,
    alignment: Alignment.Start,
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogLocationVertical,
    alignment: Alignment.Top,
  })
}


@Builder
function dialogLocationVertical() {
  Text("location")
    .width("100%")
    .height("20%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
function dialogLocationHorizontal() {
  Text("location")
    .width("30%")
    .height("100%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}
```

![customLocation](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102228928.gif)

## 跨页面交互

- 正常使用，无需设置什么参数

```typescript
export function customJumpPage() {
  SmartDialog.show({
    builder: dialogJumpPage,
  })
}

@Builder
function dialogJumpPage() {
  Text("JumPage")
    .fontSize(30)
    .padding(50)
    .borderRadius(12)
    .fontColor(Color.White)
    .backgroundColor(randomColor())
    .onClick(() => {
      // 跳转页面
    })
}
```

![customJumpPage](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102228102.gif)

## 关闭指定弹窗

```typescript
export async function customTag() {
  const animationTime = 1000
  SmartDialog.show({
    builder: dialogTagA,
    alignment: Alignment.Start,
    tag: "A",
  })
  await delay(animationTime)
  SmartDialog.show({
    builder: dialogTagB,
    alignment: Alignment.Top,
    tag: "B",
  })
}

@Builder
function dialogTagA() {
  Text("A")
    .width("20%")
    .height("100%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
function dialogTagB() {
  Flex({ wrap: FlexWrap.Wrap }) {
    ForEach(["closA", "closeSelf"], (item: string, index: number) => {
      Button(item)
        .backgroundColor("#4169E1")
        .margin(10)
        .onClick(() => {
          if (index === 0) {
            SmartDialog.dismiss({ tag: "A" })
          } else if (index === 1) {
            SmartDialog.dismiss({ tag: "B" })
          }
        })
    })
  }.backgroundColor(Color.White).width(350).margin({ left: 30, right: 30 }).padding(10).borderRadius(10)
}
```

![customTag](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102228252.gif)

## 自定义遮罩

```typescript
export function customMask() {
  SmartDialog.show({
    builder: dialogShowDialog,
    maskBuilder: dialogCustomMask,
  })
}

@Builder
function dialogCustomMask() {
  Stack().width("100%").height("100%").backgroundColor(randomColor()).opacity(0.6)
}

@Builder
function dialogShowDialog() {
  Text("showDialog")
    .fontSize(30)
    .padding(50)
    .fontColor(Color.White)
    .borderRadius(12)
    .backgroundColor(randomColor())
    .onClick(() => customMask())
}
```

![customMask](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102228981.gif)

# AttachDialog

## 默认定位

```typescript
export function attachEasy() {
  SmartDialog.show({
    builder: dialog
  })
}

@Builder
function dialog() {
  Stack() {
    Text("Attach")
      .backgroundColor(randomColor())
      .padding(20)
      .fontColor(Color.White)
      .borderRadius(5)
      .onClick(() => {
        SmartDialog.showAttach({
          targetId: "Attach",
          builder: targetLocationDialog,
        })
      })
      .id("Attach")
  }
  .borderRadius(12)
  .padding(50)
  .backgroundColor(Color.White)
}

@Builder
function targetLocationDialog() {
  Text("targetIdDialog")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .borderRadius(12)
    .backgroundColor(randomColor())
}
```

![attachEasy](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102229299.gif)

## 多方向定位

```typescript
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
    .padding(50)
    .borderRadius(12)
    .backgroundColor(randomColor())
}
```

![attachLocation](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102229386.gif)

# Loading

对于Loading而言，应该有几个比较明显的特性

- loading和dialog都存在页面上，哪怕dialog打开，loading都应该显示dialog之上
- loading应该具有单一特性，多次打开loading，页面也应该只存在一个loading
- 刷新特性，多次打开loading，后续打开的loading样式，应该覆盖之前打开的loading样式
- loading使用频率非常高，应该支持强大的拓展和极简的使用

从上面列举几个特性而言，loading是一个非常特殊的dialog，所以需要针对其特性，进行定制化的实现

当然了，内部已经屏蔽了细节，在使用上，和dialog的使用没什么区别

## 默认loading

```typescript
SmartDialog.showLoading()
```

![loadingDefault](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102229871.gif)

## 自定义Loading

- 点击loading后，会再次打开一个loading，从效果图可以看出它的单一刷新特性

```typescript
export function loadingCustom() {
  SmartDialog.showLoading({
    builder: customLoading,
  })
}

@Builder
export function customLoading() {
  Column({ space: 5 }) {
    Text("again open loading").fontSize(16).fontColor(Color.White)
    LoadingProgress().width(80).height(80).color(Color.White)
  }
  .padding(20)
  .borderRadius(12)
  .onClick(() => loadingCustom())
  .backgroundColor(randomColor())
}
```

![loadingCustom](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202408102229335.gif)
