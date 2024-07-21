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

- Tablet模拟器目前有些问题，会导致动画闪烁，请忽略

![attachLocation](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202406231725613.gif)

![customTag](https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/202406231725522.gif)

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
        MainPage()
      }
      .mode(NavigationMode.Stack)
      .hideTitleBar(true)
      .navDestination(pageMap)

      // here
      OhosSmartDialog()
    }.height('100%').width('100%')
  }
}
```

**返回事件监听**

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

**路由监听的注意事项**

- 一般来说，你无需关注SmartDialog的路由监听，因为内部已经设置了路由监听拦截器

- **但是**NavPathStack仅支持单拦截器（setInterception），如果业务代码也使用了这个api，会导致SmartDialog的路由监听被覆盖，从而失效

> **如果出现该情况，请参照下述解决方案**

- 在你的路由监听类中手动调用`OhosSmartDialog.observe`

```typescript
export default class YourNavigatorObserver implements NavigationInterception {
  willShow?: InterceptionShowCallback = (from, to, operation, isAnimated) => {
    OhosSmartDialog.observe.willShow?.(from, to, operation, isAnimated)
    // ...
  }
  didShow?: InterceptionShowCallback = (from, to, operation, isAnimated) => {
    OhosSmartDialog.observe.didShow?.(from, to, operation, isAnimated)
    // ...
  }
}
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
let isExist = SmartDialog.checkExist()
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

# Demo

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

## 定位弹窗

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
