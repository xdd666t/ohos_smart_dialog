# 1.5.0
- 增加showLoading
- 强化SmartDialog.checkExist能力, 可检测指定类型弹窗是否存在
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