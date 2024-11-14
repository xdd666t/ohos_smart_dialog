# 1.6.3
- usePenetrate: 该功能下线, 无法与Flutter容器兼容


# 1.6.2
- 增加usePenetrate: true（点击事件将穿透遮罩），false（不穿透）
- 优化dismiss逻辑

# 1.6.1
- 更新文档内容

# 1.6.0
- 使用无感路由监听，简化SmartDialog初始化流程
- 废弃手动注册路由方式，以下方法已被废弃，后续版本将被删除
  - OhosSmartDialog.observe 
  - OhosSmartDialog.registerRouter

# 1.5.8
- 下线usePenetrate: 存在问题，暂时下线

# 1.5.7
- 增加keepSingle: keepSingle设置为true，多次调用仍能保持一个弹窗；手动设置tag, 可创建多个同时存在的keepSingle弹窗

# 1.5.6
- 增加usePenetrate: 可选点击事件是否穿透遮罩, 被下层组件响应
- 优化remove逻辑

# 1.5.5
- 优化checkExist
- 优化路由监听逻辑

# 1.5.3
- 新增bindRouter: 当bindRouter为undefined时, 该弹窗将自动绑定当前路由; 如果你不想该弹窗绑定当前路由, 可将该值设置为负数("-1")

# 1.5.2
- 新增onDismiss: 弹窗关闭时, 触发该回调

# 1.5.1
- 适配暗黑模式: 切换暗黑模式时, 所有dialog自动重建

# 1.5.0
- feature
  - 增加showLoading
  - 增加设置默认loading样式
  - 定制showLoading tag能力
  - 强化SmartDialog.checkExist能力, 可检测指定类型弹窗是否存在
  - 增加backType: 返回事件对弹窗的影响
- breakChange
  - SmartDialog.config.checkExist -> SmartDialog.checkExist

# 1.3.5
- showAttach弹窗动画实现调整: 显式动画改为属性动画

# 1.3.3
- show弹窗动画实现调整: 显式动画改为属性动画

# 1.3.2
- 文档增加Shields.io徽章

# 1.3.1
- 更新文档内容

# 1.3.0
- 简化用法, 移除wrapBuilder

# 1.2.0
- 重大更新
  - 增加showAttach弹窗, 可以定位至component具体位置处显示
  - 完善attach弹窗基础动画
  - attach弹窗(showAttach)能力, 对其custom弹窗(show)
- 重构多弹窗刷新能力
- 优化tag探寻弹窗能力
- breakChange
  - wrapBuilder -> builder
  - wrapBuilderArgs -> builderArgs
  - maskWrapBuilder -> maskBuilder
  - remove SmartDialogController

# 1.1.3
- 优化alignment参数


# 1.1.2
- 简化返回事件监听写法


# 1.1.0
- 路由监听: 支持跨页面交互
- 返回事件处理
- tag标记: 弹窗搜寻, 支持关闭指定弹窗
- 遮罩自定义:  Component自定义, 点击事件抛出
- 多位置弹窗: 上下左右中间, 支持相应动画
- 完善使用demo
  - 使用弹窗, 各方向弹窗demo, 自定义遮罩, tag弹窗
  - 指定关闭, 跳转页面弹窗表现


# 1.0.0
**基本功能完成, 支持如下功能** 
- 自定义Component
- 非UI区域内使用
- 单次初始化后即可使用, 无需多处配置相关Component
- 打开多弹窗能力
- 弹窗刷新能力
- 遮罩颜色自定义
- 弹窗动画时间自定义