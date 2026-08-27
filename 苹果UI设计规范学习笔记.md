# 苹果 UI 设计规范（Apple Human Interface Guidelines）学习笔记

> 参考来源：[Apple HIG 官方文档](https://developer.apple.com/design/human-interface-guidelines/)  
> 整理日期：2025年  
> 涵盖平台：iOS 18 / macOS 15 / watchOS 11 / tvOS 18 / visionOS 2

---

## 目录

1. [设计哲学与核心原则](#1-设计哲学与核心原则)
2. [主题与外观](#2-主题与外观)
3. [图标与图像](#3-图标与图像)
4. [排版（Typography）](#4-排版typography)
5. [色彩系统（Color）](#5-色彩系统color)
6. [布局与分辨率](#6-布局与分辨率)
7. [导航与交互模式](#7-导航与交互模式)
8. [控件与组件](#8-控件与组件)
9. [动画与过渡效果](#9-动画与过渡效果)
10. [无障碍设计（Accessibility）](#10-无障碍设计accessibility)
11. [macOS 专属规范](#11-macos-专属规范)
12. [visionOS 空间计算规范](#12-visionos-空间计算规范)
13. [SF Symbols 图标系统](#13-sf-symbols-图标系统)
14. [设计资源与工具](#14-设计资源与工具)
15. [常见反模式（不要这样做）](#15-常见反模式不要这样做)

---

## 1. 设计哲学与核心原则

### 1.1 四大设计哲学

| 原则 | 含义 | 实践要点 |
|------|------|----------|
| **清晰（Clarity）** | 文字清晰可读，图标精确而易懂，装饰服务于功能 | 使用大字号确保可读；留白充足；图标简洁 |
| **一致性** | 遵循平台标准的外观和行为模式 | 使用标准控件；遵循用户预期的交互模式 |
| **深度（Depth）** | 层次感和视觉层次帮助用户理解导航关系 | 利用模糊、缩放、堆叠创造空间层次 |
| **尊重** | 让内容成为主角，UI 退居幕后 | 少即是多；减少视觉噪音 |

### 1.2 设计思维框架

Apple 推荐的设计流程：

```
需求理解 → 竞品/用户研究 → 原型设计 → 用户测试 → 迭代优化
    ↓
关键问题：你的应用帮用户解决什么问题？
         用户在什么场景下使用？
         什么是最重要的功能？
```

### 1.3 核心设计准则

1. **以内容为中心** — UI 元素不应分散用户对内容的注意力
2. **提供即时反馈** — 每次用户操作都应有视觉、触觉或声音反馈
3. **保持简洁** — 只展示当前所需信息，渐进式披露
4. **尊重用户意图** — 不要打断用户，避免不必要的弹窗
5. **提供撤销和恢复** — 让用户放心操作，降低犯错成本
6. **考虑所有人** — 无障碍设计不是可选项，是必须

---

## 2. 主题与外观

### 2.1 全局外观（Global Appearance）

| 主题 | 说明 |
|------|------|
| **Light Mode（浅色模式）** | 白色/浅色背景 |
| **Dark Mode（深色模式）** | 深色/黑色背景 |
| **Automatic（自动）** | 跟随系统设置切换 |

### 2.2 设计要求

- **必须同时支持 Light 和 Dark 模式** — 不要硬编码颜色
- 使用语义颜色（Semantic Colors）而非固定颜色
- 测试两种模式下的所有界面
- Dark 模式下不要简单反转颜色，需要精心调整

### 2.3 增强对比度（Increase Contrast）

用户可以在系统设置中开启"增强对比度"选项，设计时应：

- 使用足够粗的边框分隔元素
- 确保前景与背景的对比度 ≥ 4.5:1（WCAG AA）
- 使用系统提供的增强对比度变体颜色

---

## 3. 图标与图像

### 3.1 应用图标（App Icon）

| 平台 | 尺寸 | 格式 | 要求 |
|------|------|------|------|
| iPhone | 60×60 pt (120×120 px @2x, 180×180 px @3x) | PNG | 无圆角（系统自动裁切）|
| iPad | 76×76 pt (152×152 px @2x) | PNG | 无圆角 |
| App Store | 1024×1024 pt | PNG | 无透明度，无圆角 |
| macOS | 128×128 pt | PNG/ICNS | 提供多分辨率 |
| Apple Watch | 取决于系列 | PNG | 注意小屏可读性 |

### 3.2 图标设计原则

1. **简洁** — 避免过多细节，越小的图标越需要简化
2. **通用** — 不使用特定文化元素，面向全球用户
3. **可识别** — 能在众多图标中一眼认出
4. **避免文字** — 除非是品牌名称
5. **避免使用照片** — 使用矢量/平面设计风格
6. **保持一致性** — 整套图标风格统一

### 3.3 图像使用原则

- 使用高分辨率图像（@2x, @3x）
- 考虑不同设备尺寸的适配
- 避免将重要信息放在图像中（本地化困难）
- 提供图像的描述文本（无障碍）

---

## 4. 排版（Typography）

### 4.1 系统字体：SF Pro

| 属性 | 说明 |
|------|------|
| **字体名称** | SF Pro（San Francisco）|
| **变体** | Text（<20pt）、Display（≥20pt）|
| **权重** | Ultra Light, Thin, Light, Regular, Medium, Semibold, Bold, Heavy, Black |
| **等宽字体** | SF Mono（代码/数据场景）|
| **圆体** | SF Rounded（柔和界面元素）|

### 4.2 文本样式（Text Styles）

| 样式 | iOS/macOS 常用大小 | 用途 |
|------|---------------------|------|
| Large Title | 34pt | 页面主标题 |
| Title 1 | 28pt | 区域标题 |
| Title 2 | 22pt | 子区域标题 |
| Title 3 | 20pt | 卡片标题 |
| Headline | 17pt Semibold | 列表标题 |
| Body | 17pt | 正文内容 |
| Callout | 16pt | 辅助说明 |
| Subheadline | 15pt | 次要标题 |
| Footnote | 13pt | 注释 |
| Caption 1 | 12pt | 图片说明 |
| Caption 2 | 11pt | 最小可读文字 |

### 4.3 排版最佳实践

```
✅ 推荐做法：
• 动态字体（Dynamic Type）：支持用户调整字体大小
• 使用系统预定义的文本样式
• 确保最小行高为字号的 1.2 倍
• 段落间距 ≥ 行高的一半
• 对齐方式：左对齐（阅读方向），居中用于短文本

❌ 避免做法：
• 在小屏幕上使用 < 11pt 的文字
• 一行超过 45-75 个字符
• 全部使用大写文字（可读性差）
• 使用纯装饰性字体作为正文
• 硬编码字体大小
```

### 4.4 动态字体（Dynamic Type）

用户可在系统设置中调整文字大小，范围从 **xSmall** 到 **AX5**（辅助功能超大）。

```swift
// iOS 代码示例
label.font = UIFont.preferredFont(forTextStyle: .body)
label.adjustsFontForContentSizeCategory = true
label.numberOfLines = 0 // 允许自动换行
```

---

## 5. 色彩系统（Color）

### 5.1 语义颜色（Semantic Colors）

Apple 使用语义命名的颜色，它们会自动适应 Light/Dark 模式：

| 颜色名 | Light 模式 | Dark 模式 | 用途 |
|--------|------------|-----------|------|
| `label` | #000000 | #FFFFFF | 主要文字 |
| `secondaryLabel` | #3C3C43A0 | #EBEBF599 | 次要文字 |
| `systemBackground` | #FFFFFF | #000000 | 主背景 |
| `secondarySystemBackground` | #F2F2F7 | #1C1C1E | 次要背景 |
| `tertiarySystemBackground` | #FFFFFF | #2C2C2E | 第三级背景 |
| `separator` | #3C3C4349 | #54545899 | 分隔线 |
| `systemBlue` | #007AFF | #0A84FF | 主要操作色 |
| `systemGreen` | #34C759 | #30D158 | 成功/正值 |
| `systemRed` | #FF3B30 | #FF453A | 警告/删除 |
| `systemOrange` | #FF9500 | #FF9F0A | 次要警告 |
| `systemYellow` | #FFCC00 | #FFD60A | 注意 |
| `systemPurple` | #AF52DE | #BF5AF2 | 创意/个性化 |
| `systemPink` | #FF2D55 | #FF375F | 强调 |
| `systemTeal` | #5AC8FA | #64D2FF | 信息 |
| `systemIndigo` | #5856D6 | #5E5CE6 | 系统/管理 |

### 5.2 颜色使用原则

1. **使用语义颜色而非 RGB 值** — 保证跨主题一致性
2. **蓝色是主要操作色** — 链接、按钮、可交互元素使用 `systemBlue`
3. **红色仅用于破坏性操作** — 删除、错误
4. **确保对比度达标** — 文字与背景 ≥ 4.5:1
5. **不要仅靠颜色传达信息** — 同时使用图标、文字、纹理

### 5.3 色彩无障碍

- 色盲用户约 8% 的男性（0.5% 女性）
- 关键信息不能仅依赖颜色区分
- 使用颜色以外的指示器：✓/✗ 图标、形状差异、文字标签

---

## 6. 布局与分辨率

### 6.1 设备分辨率

| 设备 | 逻辑分辨率 (pt) | 物理分辨率 | 倍率 |
|------|------------------|------------|------|
| iPhone 16 Pro Max | 440×956 | 1320×2868 | 3x |
| iPhone 16 Pro | 402×874 | 1206×2622 | 3x |
| iPhone 16 | 393×852 | 1179×2556 | 3x |
| iPhone SE (3rd) | 375×667 | 750×1334 | 2x |
| iPad Pro 13" | 1024×1366 | 2048×2732 | 2x |
| iPad Air 13" | 1024×1366 | 2048×2732 | 2x |
| MacBook Air 15" | 1440×932 | 2880×1864 | 2x |

### 6.2 布局原则

1. **使用 Auto Layout** — 让界面自动适应不同屏幕尺寸
2. **安全区域（Safe Area）** — 内容不要延伸到刘海/灵动岛/底部横条区域
3. **最小点击目标 44×44 pt** — 这是 Apple 硬性要求
4. **内容优先** — 宁可压缩间距也不要裁切内容
5. **适配多种尺寸** — 从最大到最小屏幕都应正常显示

### 6.3 布局边距标准

```
页面边距：
• iPhone: 16-20pt（左右）
• iPad: 更宽的边距，可使用分栏

分组列表内部边距：
• 左侧图标到文字: 8pt
• 文字到右侧区域: 8pt
• 分组间距: 20-30pt
```

### 6.4 横竖屏适配

- 优先支持竖屏（Portrait）
- iPad 应同时支持横竖屏
- iPhone 可以锁定竖屏（但推荐适配）
- 转换时保持内容状态和位置不变

---

## 7. 导航与交互模式

### 7.1 导航模式

#### 标签栏导航（Tab Bar）

```
适用场景：3-5 个顶级入口
设计要点：
• 每个标签都应直接可达
• 标签文字 ≤ 10 个字符
• 选中状态使用填充图标 + 着色
• 支持长按显示更多操作（Tab Bar Menu）
• 位置：屏幕底部（iPhone）/ 窗口底部（macOS）
```

#### 导航栏（Navigation Bar）

```
适用场景：线性层级导航
设计要点：
• 返回按钮：箭头 + 上一级标题
• 标题居中（iOS）或左对齐（iPad/macOS）
• 支持大标题（Large Title）过渡效果
• 可配置工具栏按钮
```

#### 侧边栏导航（Sidebar）

```
适用场景：iPadOS、macOS 的多层级导航
设计要点：
• 支持分组（Section）
• 可折叠的分组
• 搜索栏置于顶部
• 支持拖拽重排
• iPad 中与内容并排显示
```

### 7.2 交互模式

#### 按压与长按

| 手势 | iOS | macOS | 说明 |
|------|-----|-------|------|
| 点击（Tap） | ✓ | ✓（Click） | 主要交互 |
| 长按（Long Press） | ✓ | ✓（Secondary Click） | 上下文菜单 |
| 滑动（Swipe） | ✓ | ✓（Trackpad） | 列表操作/导航 |
| 双指缩放 | ✓ | ✓（Pinch） | 缩放内容 |
| 下拉刷新 | ✓ | — | 刷新数据 |
| 上拉加载更多 | ✓ | — | 分页加载 |
| 拖拽 | ✓ | ✓ | 重排/移动 |
| 三指滑动 | ✓（复制/粘贴） | — | 系统快捷操作 |

### 7.3 重要的交互规则

1. **永远提供反馈** — 触觉反馈（Haptic）、视觉反馈
2. **不要重新发明按钮** — 用户需要明确知道什么可以点击
3. **手势要直觉** — 不要强制使用隐藏手势
4. **支持撤销** — 特别是删除操作
5. **渐进式披露** — 先展示核心功能，高级选项藏在二级页面

---

## 8. 控件与组件

### 8.1 核心控件速查

| 控件 | 用途 | 注意事项 |
|------|------|----------|
| **Button** | 触发操作 | 重要操作用填充样式，次要用文字样式 |
| **Toggle / Switch** | 开关切换 | 操作立即生效，不需要确认 |
| **Slider** | 调节连续值 | 如音量、亮度 |
| **Stepper** | 调节离散值 | 步长可为 1 或自定义 |
| **Segment Control** | 切换视图/选项 | ≤ 5 个选项 |
| **TextField** | 单行输入 | 提供清晰的占位符 |
| **TextView** | 多行输入 | 支持自动高度扩展 |
| **Picker** | 选择器 | iOS 使用滚轮/弹出 |
| **DatePicker** | 日期选择 | 根据场景选择样式 |
| **SearchBar** | 搜索 | 放在页面顶部 |
| **ProgressIndicator** | 进度指示 | 区分确定和不确定进度 |
| **Alert** | 警告弹窗 | 只在重要场景使用 |
| **ActionSheet / ContextMenu** | 操作菜单 | iOS 优先使用 ContextMenu |
| **Sheet** | 模态页面 | 从底部弹出 |
| **NavigationSplitView** | 分栏导航 | iPad/Mac 适配 |

### 8.2 按钮样式层级

```
层级 1（最强调）：Filled Button — 填充背景色 + 白色文字
层级 2（中等强调）：Tinted Button — 浅色背景 + 主题色文字
层级 3（次要强调）：Gray Button — 浅灰色背景 + 标题色文字
层级 4（弱强调）：Borderless Button — 纯文字，无边框
```

### 8.3 列表与表格

```
Grouped List（分组列表）：
• 系统设置的经典外观
• 有分组标题和页脚
• 背景色为灰色

Inset Grouped List（内嵌分组列表）：
• iOS 13+ 引入
• 列表两侧有圆角
• 现代 App 首选

Plain List（普通列表）：
• 无分组，连续滚动
• 适合通讯录等长列表
```

### 8.4 表单设计规范

1. 标签在输入框上方，不要使用内联标签
2. 必填字段使用红色星号 `*`
3. 输入错误时在字段下方显示红色错误提示
4. 提供合适的键盘类型（数字、邮箱、URL 等）
5. 自动填充（AutoFill）支持：姓名、地址、信用卡等
6. 表单提交按钮使用 Filled 样式，放在表单底部

---

## 9. 动画与过渡效果

### 9.1 动画原则

| 原则 | 说明 |
|------|------|
| **流畅** | 保持 60fps，不掉帧 |
| **有意义** | 动画服务于功能，不是装饰 |
| **响应式** | 响应用户的交互速度 |
| **可中断** | 用户可以随时打断动画 |
| **物理真实** | 模拟真实的物理运动曲线 |

### 9.2 常见动画模式

```
页面过渡：
• Push/Pop（推进/弹出）：从右侧滑入/滑出
• Modal（模态）：从底部上滑
• Cover（覆盖）：放大覆盖全屏

列表交互：
• 插入/删除：平滑展开/收缩
• 重排：流畅的位置移动
• 下拉刷新：惯性回弹

按钮反馈：
• 按下时轻微缩小
• 释放时弹性恢复
• 配合 Haptic 反馈

加载状态：
• 骨架屏（Skeleton Screen）
• 脉动动画（Pulse）
• 旋转加载器
```

### 9.3 避免的动画

- ❌ 纯装饰性动画（没有功能意义）
- ❌ 阻断用户操作的强制动画
- ❌ 频繁闪烁的动画（可能引发癫痫）
- ❌ 超过 3 秒的不可跳过动画
- ❌ 与用户操作方向相反的动画

---

## 10. 无障碍设计（Accessibility）

### 10.1 核心要求

| 特性 | 要求 |
|------|------|
| **VoiceOver** | 所有可交互元素必须有标签 |
| **动态字体** | 文字必须支持缩放 |
| **对比度** | 文字 ≥ 4.5:1，大文字 ≥ 3:1 |
| **颜色** | 不能仅靠颜色传达信息 |
| **触控目标** | 最小 44×44 pt |
| **减少动态效果** | 支持"减少运动"设置 |
| **辅助功能标签** | 每个元素都有清晰的描述 |

### 10.2 无障碍最佳实践

```
1. 为所有图片添加描述（alt text）
2. 为图标按钮提供文字标签
3. 使用标题层级（H1→H2→H3）构建内容结构
4. 确保所有功能可通过键盘完成
5. 表单控件必须关联标签
6. 错误提示必须可被屏幕阅读器读取
7. 不要使用闪烁内容
8. 支持高对比度模式
9. 提供足够大的点击区域
10. 测试：开启 VoiceOver 能否正常使用你的 App
```

### 10.3 VoiceOver 支持

```swift
// 设置无障碍标签
button.accessibilityLabel = "删除"
button.accessibilityHint = "双击删除此项目"
button.accessibilityTraits = .button

// 标记装饰性图片
imageView.isAccessibilityElement = false

// 分组相关元素
header.isAccessibilityElement = true
header.accessibilityLabel = "标题：项目列表，共 5 个项目"
```

---

## 11. macOS 专属规范

### 11.1 窗口管理

| 特性 | 说明 |
|------|------|
| **Title Bar** | 包含红绿灯按钮（关闭/最小化/最大化）|
| **Toolbar** | 工具栏按钮位于标题栏右侧 |
| **Sidebar** | 可收起的侧边导航栏 |
| **Inspector** | 右侧属性检查器面板 |
| **全屏支持** | 点击绿色按钮进入全屏 |

### 11.2 macOS 独有交互

- **菜单栏（Menu Bar）** — 每个 App 都应有完整的菜单栏
- **右键菜单（Context Menu）** — 右键点击显示操作
- **拖放（Drag & Drop）** — 系统级支持
- **Services 菜单** — App 间数据共享
- **偏好设置窗口** — 使用工具栏样式（Toolbar-style）
- **About 窗口** — 应用信息面板

### 11.3 macOS 窗口尺寸

```
• 不要硬编码窗口大小
• 提供合理的默认大小
• 允许用户自由调整大小
• 记住并恢复上次的窗口位置和大小
• 支持最小尺寸限制
```

---

## 12. visionOS 空间计算规范

### 12.1 核心概念

| 概念 | 说明 |
|------|------|
| **Window（窗口）** | 2D 内容在 3D 空间中的平面窗口 |
| **Volume（体积）** | 3D 内容容器，可展示立体对象 |
| **Full Space（全空间）** | 完全沉浸式的 3D 环境 |
| **Immersive Space** | 沉浸式体验的入口 |
| **Shared Space** | 多个窗口共存的默认空间 |

### 12.2 设计要点

1. **窗口默认距离用户约 2-3 米**
2. **使用圆角矩形窗口**（系统自动裁切）
3. **窗口自带光照和阴影效果**
4. **支持用户自由移动窗口位置**
5. **眼动追踪 + 手势** 作为主要交互方式
6. **3D 内容要考虑光照一致性**

---

## 13. SF Symbols 图标系统

### 13.1 概述

SF Symbols 是 Apple 提供的 **5000+ 图标库**，与 San Francisco 字体配合使用。

### 13.2 使用原则

| 特性 | 说明 |
|------|------|
| **免费** | 所有平台免费使用 |
| **可变权重** | 支持 9 种粗细变化 |
| **可变尺寸** | 7 种预设尺寸 + 自定义 |
| **着色** | 可使用系统颜色或自定义 |
| **动画** | 支持 5 种内置动画类型 |
| **分层** | 支持多层着色图标 |

### 13.3 尺寸指南

```
Small:     用于 Tab Bar 图标、小按钮
Medium:    用于列表图标、导航栏图标
Large:     用于大按钮图标
Extra Large: 用于强调展示
```

### 13.4 选择 SF Symbol 的原则

1. 优先使用 SF Symbols，自定义图标作为备选
2. 选择语义匹配的图标（如 trash → 删除）
3. 保持同一 App 内图标风格一致
4. 不要在 SF Symbol 上叠加额外文字

---

## 14. 设计资源与工具

### 14.1 Apple 官方资源

| 资源 | 说明 | 链接 |
|------|------|------|
| **HIG 官方文档** | 完整设计规范 | https://developer.apple.com/design/human-interface-guidelines/ |
| **Figma 设计模板** | iOS/macOS/SwiftUI 组件库 | https://developer.apple.com/design/resources/ |
| **SF Symbols App** | 图标库浏览器 | Mac App Store |
| **Xcode Interface Builder** | 界面构建工具 | Xcode 内置 |
| **SwiftUI Previews** | 实时预览代码效果 | Xcode 内置 |

### 14.2 设计工具推荐

- **Figma** — Apple 官方提供 Figma 组件库
- **Sketch** — macOS 原生设计工具
- **Xcode Storyboard/SwiftUI** — 直接用代码设计

---

## 15. 常见反模式（不要这样做）

### 15.1 绝对不要

| ❌ 反模式 | ✅ 正确做法 |
|-----------|-------------|
| 硬编码颜色值 | 使用语义颜色 |
| 固定字体大小 | 使用 Dynamic Type |
| 忽略无障碍 | 支持 VoiceOver |
| 自定义所有控件 | 优先使用系统控件 |
| 强制弹窗请求评价 | 使用系统 StoreKit 评价 |
| 使用自定义手势做核心操作 | 使用标准手势 |
| 底部标签栏超过 5 个 | 控制在 3-5 个 |
| 不支持深色模式 | 必须双模式适配 |
| 小于 44pt 的点击区域 | 至少 44×44 pt |
| 纯色块分割内容 | 使用系统分隔线 |

### 15.2 设计审查清单

```
□ 支持 Light/Dark 两种模式
□ 支持 Dynamic Type 字体缩放
□ 所有图片有无障碍描述
□ 点击区域 ≥ 44pt
□ 对比度 ≥ 4.5:1
□ 使用系统标准控件
□ 有明确的导航层级
□ 提供反馈（视觉/触觉/声音）
□ 支持撤销操作
□ 不打断用户（减少弹窗）
□ 适配所有目标设备尺寸
□ 通过 VoiceOver 测试
```

---

## 附录：iOS UI 尺寸速查表

```
┌─────────────────────────────────────┐
│           状态栏 (44pt)              │
├─────────────────────────────────────┤
│  ┌─ 导航栏 (44pt) ───────────────┐  │
│  │    ← 返回    标题    ＋       │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌─ 内容区域 ────────────────────┐  │
│  │                               │  │
│  │  边距: 16-20pt               │  │
│  │                               │  │
│  │  列表项高度: 44pt (最小)     │  │
│  │  分组间距: 20-30pt           │  │
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌─ 标签栏 (49pt) ──────────────┐  │
│  │  🏠     🔍     ⚙️     👤    │  │
│  └───────────────────────────────┘  │
│           底部安全区域 (34pt)        │
└─────────────────────────────────────┘

总高度: iPhone 15 Pro = 852pt
内容可用高度 ≈ 852 - 44 - 44 - 49 - 34 = 681pt
```

---

*本文档为 Apple Human Interface Guidelines 的学习笔记，基于官方文档整理。*
*具体细节请参考 Apple 官方最新文档：https://developer.apple.com/design/human-interface-guidelines/*

---

---

# 第二部分：iOS 18 / macOS 15 新特性与进阶实践

---

## 16. iOS 18 设计更新要点

### 16.1 全新可定制主屏幕

iOS 18 给予用户前所未有的主屏幕自定义能力：

```
新增特性：
• 图标可自由放置在任意位置（不再强制对齐网格）
• 支持深色/着色图标主题
• 图标可以放大显示（移除文字标签）
• Widget 可放在任意位置
• 用户可以锁定/隐藏应用
```

**设计影响：**
- App 图标需要支持 Light、Dark、Tinted 三种外观
- 提供单色/简化的图标版本供着色模式使用
- 不能假设用户的图标会按你的预期排列

### 16.2 全新 Tab Bar 设计

```
iOS 18 Tab Bar 变化：
• 默认变为浮动式（Floating Tab Bar）
• 支持自定义图标和着色
• 支持 Tab Bar Menu（长按展开更多选项）
• 自适应 iPad 定位（底部→顶部侧边栏）
• 可配置为 Search Bar 集成样式
```

### 16.3 控制中心自定义

用户可以自定义控制中心的布局，App 提供的控制控件（Control Widget）将出现在这里。

### 16.4 游戏模式（Game Mode）

- 自动优化 CPU/GPU 性能
- 最低音频延迟
- 优化手柄输入延迟

---

## 17. macOS 15 Sequoia 设计更新

### 17.1 窗口管理改进

| 新特性 | 说明 |
|--------|------|
| **自动平铺** | 窗口自动排列不重叠 |
| **自定义定位** | 拖拽窗口到屏幕边缘自动调整大小 |
| **多显示器支持** | 每个显示器独立管理窗口布局 |

### 17.2 系统级改新

- **密码应用** — 系统内置密码管理 App
- **iPhone 镜像** — 在 Mac 上操作 iPhone
- **小组件改进** — 可直接在桌面使用 iPhone 应用的小组件

---

## 18. SwiftUI 设计实践

### 18.1 常用视图组件

```swift
// MARK: - 基础视图结构
struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("基本设置") {
                    // 标准行
                    HStack {
                        Image(systemName: "wifi")
                            .foregroundColor(.blue)
                        Text("Wi-Fi")
                        Spacer()
                        Text("MyNetwork")
                            .foregroundColor(.secondary)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("设置")
        }
    }
}

// MARK: - 表单视图
struct SettingsForm: View {
    @State private var username = ""
    @State private var notifications = true
    @State private var theme = 0
    
    var body: some View {
        Form {
            Section("个人信息") {
                TextField("用户名", text: $username)
                    .textContentType(.username)
                    .autocapitalization(.none)
            }
            
            Section("偏好设置") {
                Toggle("通知", isOn: $notifications)
                Picker("主题", selection: $theme) {
                    Text("自动").tag(0)
                    Text("浅色").tag(1)
                    Text("深色").tag(2)
                }
            }
        }
        .navigationTitle("偏好设置")
    }
}

// MARK: - 警告弹窗
struct AlertExample: View {
    @State private var showAlert = false
    
    var body: some View {
        Button("删除项目") {
            showAlert = true
        }
        .alert("确认删除", isPresented: $showAlert) {
            Button("取消", role: .cancel) { }
            Button("删除", role: .destructive) {
                // 执行删除
            }
        } message: {
            Text("此操作不可撤销，确定要删除吗？")
        }
    }
}

// MARK: - 自定义样式按钮
struct CustomButtonStyles: View {
    var body: some View {
        VStack(spacing: 16) {
            Button("主要操作") { }
                .buttonStyle(.borderedProminent)
            
            Button("次要操作") { }
                .buttonStyle(.bordered)
            
            Button("文字操作") { }
                .buttonStyle(.borderless)
        }
    }
}

// MARK: - 模态视图（Sheet）
struct SheetExample: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("显示详情") {
            showingSheet = true
        }
        .sheet(isPresented: $showingSheet) {
            NavigationStack {
                Text("Sheet 内容")
                    .navigationTitle("详情")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("关闭") {
                                showingSheet = false
                            }
                        }
                    }
            }
        }
    }
}
```

### 18.2 无障碍支持代码

```swift
// MARK: - VoiceOver 支持
struct AccessibleView: View {
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text("评分：4.5 星")
        }
        // 将整个 HStack 作为一个无障碍元素
        .accessibilityElement(children: .combine)
        .accessibilityLabel("评分 4.5 星，满分 5 星")
        
        // 可调节元素
        Slider(value: .constant(0.5))
            .accessibilityLabel("音量")
            .accessibilityValue("50%")
        
        // 图标按钮
        Button(action: {}) {
            Image(systemName: "trash")
        }
        .accessibilityLabel("删除")
        .accessibilityHint("双击删除当前项目")
        
        // 仅装饰性图片
        Image("decorative-bg")
            .accessibilityHidden(true)
    }
}

// MARK: - 支持 Dynamic Type
struct DynamicTypeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("大标题")
                .font(.largeTitle)
            
            Text("这是正文内容")
                .font(.body)
            
            Text("这是注释")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        // 以上字体样式自动响应 Dynamic Type
    }
}

// MARK: - 增强对比度支持
struct ContrastView: View {
    var body: some View {
        VStack {
            Text("重要提示")
                .foregroundStyle(.primary) // 自动适应增强对比度
            
            Divider() // 自动加粗
            
            Text("次要信息")
                .foregroundStyle(.secondary)
        }
        .accessibilityAddTraits(.isHeader)
    }
}
```

---

## 19. 设计模式速查

### 19.1 常见页面布局模式

```
┌─────────────────────────────────────────────┐
│ 1. 全屏内容流（Feed/Stream）                 │
│  ┌─────────────────────────────────────┐    │
│  │ [图片/文字卡片]                     │    │
│  ├─────────────────────────────────────┤    │
│  │ [图片/文字卡片]                     │    │
│  ├─────────────────────────────────────┤    │
│  │ ...                                │    │
│  └─────────────────────────────────────┘    │
│  适用：社交、新闻、内容平台                   │
├─────────────────────────────────────────────┤
│ 2. 分组设置列表（Settings）                  │
│  ┌─────────────────────────────────────┐    │
│  │ ○○○ 设置组 A                       │    │
│  │ ├─ 选项 1              value →    │    │
│  │ ├─ 选项 2              value →    │    │
│  │ └─ 选项 3              toggle     │    │
│  ├─────────────────────────────────────┤    │
│  │ ○○○ 设置组 B                       │    │
│  │ ...                                │    │
│  └─────────────────────────────────────┘    │
│  适用：设置、偏好、个人信息                   │
├─────────────────────────────────────────────┤
│ 3. 仪表盘/概览（Dashboard）                  │
│  ┌──────────────┬──────────────────┐        │
│  │ [数据卡片 1] │ [数据卡片 2]     │        │
│  ├──────────────┼──────────────────┤        │
│  │ [图表/统计]  │ [快捷操作]       │        │
│  └──────────────┴──────────────────┘        │
│  适用：效率工具、数据分析                     │
├─────────────────────────────────────────────┤
│ 4. 主从导航（Master-Detail）                 │
│  ┌──────────┬────────────────────┐          │
│  │ 列表项 1 │  详细内容          │          │
│  │ 列表项 2 │                    │          │
│  │ 列表项 3 │                    │          │
│  │ 列表项 4 │                    │          │
│  └──────────┴────────────────────┘          │
│  适用：邮件、备忘录、文件管理                 │
├─────────────────────────────────────────────┤
│ 5. 卡片/瀑布流（Card Layout）                │
│  ┌───────┐ ┌───────┐ ┌───────┐              │
│  │ 图片  │ │ 图片  │ │ 图片  │              │
│  │ 标题  │ │ 标题  │ │ 标题  │              │
│  └───────┘ └───────┘ └───────┘              │
│  ┌───────┐ ┌───────┐ ┌───────┐              │
│  │ ...   │ │ ...   │ │ ...   │              │
│  └───────┘ └───────┘ └───────┘              │
│  适用：电商、图片浏览、作品集                 │
└─────────────────────────────────────────────┘
```

### 19.2 操作反馈模式

| 操作类型 | 反馈方式 | 示例 |
|----------|----------|------|
| 点击按钮 | 触觉 + 视觉（高亮/缩放） | 发送消息 |
| 切换开关 | 触觉反馈 | 开启通知 |
| 删除 | 确认弹窗 + 撤销提示 | 删除邮件 |
| 提交表单 | 进度指示 → 成功提示 | 注册账号 |
| 下拉刷新 | 动画 + 数据更新 | 刷新时间线 |
| 错误 | 错误提示 + 重试按钮 | 网络错误 |
| 加载中 | 骨架屏 / 脉动加载器 | 加载内容 |

---

## 20. 国际化与本地化

### 20.1 设计注意事项

```
1. 文字扩展：德语/法语等语言文字通常比英语长 30-50%
   • 按钮宽度要能自适应
   • 不要硬编码文字位置
   
2. 文字方向：
   • 阿拉伯语/希伯来语从右到左（RTL）
   • 布局需要镜像翻转
   • 图标方向也要翻转（如箭头、进度条）

3. 日期/时间格式：
   • 使用系统日期格式化器
   • 不要硬编码日期格式

4. 数字格式：
   • 千位分隔符：1,000（美）vs 1.000（德）
   • 小数点：1.5（美）vs 1,5（德）

5. 文化差异：
   • 颜色含义在不同文化中不同
   • 手势含义可能不同
   • 图标可能需要替换
```

### 20.2 支持 RTL 的布局

```swift
// SwiftUI 自动支持 RTL
HStack {
    Image(systemName: "arrow.left") // RTL 时自动翻转
    Text("返回")
}
.environment(\.layoutDirection, .rightToLeft)

// 使用 leading/trailing 代替 left/right
.padding(.leading, 16) // 不是 .padding(.left, 16)
```

---

## 21. 性能与设计

### 21.1 性能感知设计

| 策略 | 说明 |
|------|------|
| **骨架屏** | 数据加载时先显示页面结构 |
| **渐进加载** | 先加载文字，后加载图片 |
| **缓存复用** | 已加载内容立即展示 |
| **预加载** | 在用户需要前预取数据 |
| **懒加载** | 只加载可见区域的内容 |
| **分页** | 一次加载适量数据 |

### 21.2 设计中的性能意识

```
❌ 性能陷阱：
• 首屏使用大量高分辨率图片
• 同时播放多个动画
• 复杂的模糊/毛玻璃效果层叠
• 大量嵌套的阴影效果
• 频繁触发重新布局

✅ 优化建议：
• 图片使用合适的尺寸和格式（WebP）
• 首屏只加载必要内容
• 模糊效果限制层数
• 减少不必要的视图层级
• 使用 @State 减少无效刷新
```

---

## 22. Apple 设计趋势（2024-2025）

### 22.1 设计趋势总结

| 趋势 | 说明 |
|------|------|
| **空间化界面** | visionOS 推动 3D 空间交互 |
| **个性化** | 用户可深度自定义外观 |
| **AI 整合** | Apple Intelligence 作为设计元素 |
| **简洁至上** | 更少视觉噪音，更多内容 |
| **触觉丰富** | 触觉反馈成为核心交互方式 |
| **连续性体验** | iPhone → iPad → Mac → Watch 无缝衔接 |
| **暗色优先** | Dark Mode 成为主流审美 |
| **大标题回归** | 强调内容层级和可读性 |

### 22.2 Apple Intelligence 设计指南

```
AI 功能设计原则：
• 透明性：让用户知道 AI 在做什么
• 可控性：用户可以撤销 AI 操作
• 隐私：明确说明数据如何使用
• 辅助性：AI 辅助而非替代用户决策
• 一致性：AI 功能与 App 整体风格统一
```

---

## 23. 设计审查流程

### 23.1 自查清单（完整版）

#### 视觉设计
- [ ] 支持 Light 和 Dark 模式
- [ ] 使用系统语义颜色
- [ ] 字体使用预定义文本样式
- [ ] 支持 Dynamic Type
- [ ] 对比度达标（4.5:1）
- [ ] 图标风格统一
- [ ] 间距/边距一致

#### 交互设计
- [ ] 点击区域 ≥ 44pt
- [ ] 操作有即时反馈
- [ ] 支持手势操作
- [ ] 导航层级清晰
- [ ] 提供撤销能力
- [ ] 不打断用户

#### 无障碍
- [ ] VoiceOver 可正常浏览
- [ ] 所有图片有描述
- [ ] 支持键盘导航（macOS）
- [ ] 支持高对比度模式
- [ ] 支持减少动态效果

#### 本地化
- [ ] 所有文字可翻译
- [ ] 支持 RTL 布局
- [ ] 日期/时间/数字格式化
- [ ] 图标无文化敏感内容

#### 性能
- [ ] 首屏加载 < 2 秒
- [ ] 图片经过优化
- [ ] 滚动流畅无卡顿
- [ ] 内存使用合理

---

## 24. 学习资源推荐

### 24.1 必看资源

| 资源 | 链接 | 说明 |
|------|------|------|
| Apple HIG | https://developer.apple.com/design/human-interface-guidelines/ | 官方规范 |
| WWDC Videos | https://developer.apple.com/videos/ | 每年设计相关 Session |
| SF Symbols | https://developer.apple.com/sf-symbols/ | 图标库 |
| Apple Design Resources | https://developer.apple.com/design/resources/ | Figma 模板 |
| Accessibility | https://developer.apple.com/accessibility/ | 无障碍指南 |

### 24.2 推荐 WWDC Session

```
设计相关：
• WWDC24: Design for liquid glass
• WWDC24: What's new in SwiftUI
• WWDC24: Design widgets for Smart Standby
• WWDC23: Design for visionOS
• WWDC23: Swift Charts (数据可视化)
• WWDC23: What's new in UIKit
• WWDC22: Creating accessible app experiences
• WWDC21: UIKit 回顾与更新
```

### 24.3 设计社区

- **HIG - 来自 Apple 的设计师社区**
- **Dribbble / Behance** — 灵感来源
- **Figma Community** — 免费设计资源
- **Apple Developer Forums** — 技术问题讨论

---

## 25. 快速参考卡片

### iOS 常用尺寸

```
状态栏高度：    44pt (有灵动岛) / 47pt (无灵动岛)
导航栏高度：    44pt (标准) / 96pt (大标题展开)
标签栏高度：    49pt (标准) / 83pt (带安全区域)
底部安全区域：  34pt (有横条) / 0pt (无横条)
最小按钮高度：  44pt
列表行高：      44pt (最小) / 可变
键盘高度：      336pt (竖屏) / 408pt (横屏)
```

### macOS 常用尺寸

```
标题栏高度：    28pt (标准) / 52pt (带工具栏)
工具栏高度：    36pt (单行)
侧边栏宽度：    最小 150pt / 推荐 200-300pt
最小窗口尺寸：  由内容决定
菜单栏高度：    25pt (系统菜单栏)
```

### Apple Watch 尺寸

```
41mm: 176×215 pt
45mm: 198×242 pt
46mm: 205×250 pt
49mm: 226×274 pt
```

---

*学习笔记完。持续关注 Apple 官方更新，每年 WWDC 会带来新的设计指南。*
