# ohos_smart_dialog

**强大的SmartDialog**

- 单次初始化后即可使用，无需多处配置相关Component
- 非UI区域内使用
- 自定义Component
- 弹窗中打开页面的优雅交互
- 返回事件处理
- 打开多弹窗能力
- 多位置弹窗: 上下左右中间

鸿蒙版本的SmartDialog，功能会逐步和 [flutter_smart_dialog](https://github.com/fluttercandies/flutter_smart_dialog) 对齐（长期），api会尽量保持一致

但凡用过鸿蒙原生弹窗，就能体会到有多么难用和奇葩，我就不吐槽了！！！实在受不了，就把鸿蒙版的SmartDialog写出来了，由于鸿蒙api的设计和相关限制，用法和相关初始化都有一定程度的妥协。

# 安装

- github：https://github.com/xdd666t/ohos_smart_dialog
- ohos：https://ohpm.openharmony.cn/#/cn/detail/ohos_smart_dialog

```typescript
 ohpm install ohos_smart_dialog 
```

# 初始化

**配置完下述的初始化操作后，你将可以在任何地方使用弹窗，没有任何限制**

- 因为弹窗需要处理跨页面交互，必须要监控路由

```typescript
@Entry
@Component
struct Index {
  navPathStack: NavPathStack = new NavPathStack()
  
  build() {
    Stack() {
      // here: monitor router
      Navigation(OhosSmartDialog.registerRouter(this.navPathStack)) {
        buildMainPage()
      }
      .mode(NavigationMode.Stack)
      .navDestination(pageMap)

      // here
      OhosSmartDialog()
    }.height('100%').width('100%')
  }
}
```

> **返回事件监听**

别怪我为啥返回事件的监听，处理的这么麻烦，鸿蒙里面没找全局返回事件监听，我也没办法呀。。。

- Entry页面处理

```typescript
@Entry
@Component
struct Index {
  build() {
    // ....
  }

  // here
  onBackPress(): boolean | void {
    if (OhosSmartDialog.onBackPressed()) {
      return true
    }
    return false
  }
}
```

- 路由子页面：如果你也需要处理返回事件，请参照Entry页面中的处理

```typescript
@Component
struct JumpPage {
  build() {
    NavDestination() {
      Stack()
    }
    .hideTitleBar(true)
      // here
      .onBackPressed(OhosSmartDialog.onBackPressed)
  }
}
```

# 使用

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
```

## 传参弹窗

```typescript
function useArgs() {
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogArgs),
    wrapBuilderArgs: { msg: Math.random().toString() } as ArgsModel
  })
}

@Builder
export function dialogArgs(args: ArgsModel) {
  Text(args.msg)
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .margin(50)
    .backgroundColor(Color.Blue)
}

export class ArgsModel {
  msg: string = ""
}
```

## 多位置弹窗

```typescript
async function location() {
  const animationTime = 1000
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogLocationHorizontal),
    alignment: Alignment.End,
  })
  await delay(animationTime)
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogLocationVertical),
    alignment: Alignment.Bottom,
  })
  await delay(animationTime)
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogLocationCenter),
    alignment: Alignment.Center,
  })
}

@Builder
export function dialogLocationVertical() {
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
export function dialogLocationHorizontal() {
  Text("location")
    .width("30%")
    .height("100%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
export function dialogLocationCenter() {
  Text("location")
    .width("30%")
    .height("30%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}
```

## 指定关闭弹窗

```typescript
async function tag() {
  const animationTime = 1000
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogTagA),
    alignment: Alignment.Start,
    tag: "A",
  })
  await delay(animationTime)
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogTagB),
    alignment: Alignment.Top,
    tag: "B",
  })
  await delay(animationTime)
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogTagC),
    alignment: Alignment.Center,
    tag: "C",
  })
}

@Builder
export function dialogTagA() {
  Text("A")
    .width("20%").height("100%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
export function dialogTagB() {
  Text("B")
    .width("100%")
    .height("20%")
    .fontSize(20)
    .fontColor(Color.White)
    .textAlign(TextAlign.Center)
    .padding(50)
    .backgroundColor(randomColor())
}

@Builder
export function dialogTagC() {
  Flex({ wrap: FlexWrap.Wrap }) {
    ForEach(["closA", "closeB", "closeSelf"], (item: string, index: number) => {
      Button(item)
        .backgroundColor(Color.Orange)
        .margin(10)
        .onClick(() => {
          if (index === 0) {
            SmartDialog.dismiss({ tag: "A" })
          } else if (index === 1) {
            SmartDialog.dismiss({ tag: "B" })
          } else if (index === 2) {
            SmartDialog.dismiss({ tag: "C" })
          }
        })
    })
  }.backgroundColor(Color.Blue).margin({ left: 30, right: 30 })
}
```

## 自定义遮罩

```typescript
function customMask() {
  SmartDialog.show({
    wrapBuilder: wrapBuilder(dialogShowDialog),
    maskWrapBuild: wrapBuilder(dialogCustomMask),
  })
}

@Builder
export function dialogShowDialog() {
  Text("showDialog")
    .fontSize(30)
    .padding(50)
    .backgroundColor(randomColor())
    .onClick(() => {
      SmartDialog.show({
        wrapBuilder: wrapBuilder(dialogShowDialog),
      })
    })
}

@Builder
export function dialogCustomMask() {
  Stack().width("100%").height("100%").backgroundColor(randomColor()).opacity(0.6)
}
```

