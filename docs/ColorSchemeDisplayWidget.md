# ColorSchemeDisplayWidget 组件说明

## 概述
`ColorSchemeDisplayWidget` 是一个用于展示 Flutter Material Design 3 ColorScheme 中所有基础颜色的组件。该组件支持动态更新颜色方案，并提供点击复制颜色代码的功能。

## 功能特性
1. **完整的颜色展示**：展示 ColorScheme 中的所有颜色，包括 Primary、Secondary、Tertiary、Surface 和 Error 五大类别
2. **动态更新**：当父组件传入的 ColorScheme 发生变化时，组件会自动刷新显示
3. **交互功能**：点击任意颜色块可复制其十六进制颜色代码到剪贴板
4. **用户友好的设计**：每个颜色块显示颜色名称和十六进制代码，采用适合的对比色确保文字可读性

## 使用方法

### 基础用法
```dart
ColorSchemeDisplayWidget(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
  title: 'ColorScheme 总览',
)
```

### 带回调的用法
```dart
ColorSchemeDisplayWidget(
  colorScheme: myColorScheme,
  title: '自定义标题',
  onColorCopied: () {
    // 颜色复制后的回调处理
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('颜色代码已复制')),
    );
  },
)
```

## 参数说明

| 参数 | 类型 | 必需 | 默认值 | 说明 |
|------|------|------|--------|------|
| `colorScheme` | `ColorScheme` | 是 | - | 要展示的颜色方案 |
| `title` | `String` | 否 | `'ColorScheme 总览'` | 组件标题 |
| `onColorCopied` | `VoidCallback?` | 否 | `null` | 颜色复制后的回调函数 |

## 颜色分类

### Primary（主色）
- primary - 主要颜色
- onPrimary - 主要颜色上的文字颜色
- primaryContainer - 主要容器颜色
- onPrimaryContainer - 主要容器上的文字颜色
- primaryFixed - 固定主要颜色
- onPrimaryFixed - 固定主要颜色上的文字颜色
- primaryFixedDim - 暗淡的固定主要颜色
- onPrimaryFixedVariant - 固定主要颜色变体上的文字颜色

### Secondary（辅助色）
- secondary - 辅助颜色
- onSecondary - 辅助颜色上的文字颜色
- secondaryContainer - 辅助容器颜色
- onSecondaryContainer - 辅助容器上的文字颜色
- secondaryFixed - 固定辅助颜色
- onSecondaryFixed - 固定辅助颜色上的文字颜色
- secondaryFixedDim - 暗淡的固定辅助颜色
- onSecondaryFixedVariant - 固定辅助颜色变体上的文字颜色

### Tertiary（第三色）
- tertiary - 第三颜色
- onTertiary - 第三颜色上的文字颜色
- tertiaryContainer - 第三容器颜色
- onTertiaryContainer - 第三容器上的文字颜色
- tertiaryFixed - 固定第三颜色
- onTertiaryFixed - 固定第三颜色上的文字颜色
- tertiaryFixedDim - 暗淡的固定第三颜色
- onTertiaryFixedVariant - 固定第三颜色变体上的文字颜色

### Surface（表面色）
- surface - 表面颜色
- surfaceContainerLowest - 最低表面容器颜色
- surfaceContainerHighest - 最高表面容器颜色
- inverseSurface - 反向表面颜色
- surfaceDim - 暗淡表面颜色
- surfaceContainerLow - 低表面容器颜色
- shadow - 阴影颜色
- onInverseSurface - 反向表面上的文字颜色
- onSurface - 表面上的文字颜色
- surfaceContainer - 表面容器颜色
- scrim - 遮罩颜色
- outline - 轮廓颜色
- onSurfaceVariant - 表面变体上的文字颜色
- surfaceContainerHigh - 高表面容器颜色
- surfaceTint - 表面着色颜色
- outlineVariant - 轮廓变体颜色
- surfaceBright - 明亮表面颜色
- inversePrimary - 反向主要颜色

### Error（错误色）
- error - 错误颜色
- errorContainer - 错误容器颜色
- onError - 错误颜色上的文字颜色
- onErrorContainer - 错误容器上的文字颜色

## 实现细节
- 组件采用 Card 布局，提供阴影效果
- 使用 Wrap 布局展示颜色块，支持自动换行
- 每个颜色块都有轻微的边框和阴影效果
- 颜色代码格式为大写十六进制（如：#FF9800）
- 点击颜色块时会自动复制颜色代码到系统剪贴板

## 注意事项
1. 组件需要在有 Scaffold 的上下文中使用（用于显示 SnackBar）
2. 确保传入的 ColorScheme 实例是有效的
3. 建议在父组件中处理 `onColorCopied` 回调以提供用户反馈
4. 组件会根据颜色的明暗自动选择合适的文字颜色以确保可读性
