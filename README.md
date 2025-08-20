# AIFlutter 我的 Flutter 学习实践记录 基于 3.27.4 版本

一个专门用于学习和实践Flutter框架的项目，包含了多个精彩的动画效果和应用示例。

## 项目特色

### 🎆 烟花动画应用 (FireworksApp)
- **文件位置**: `lib/app/mediaKitApp/firework_app.dart`
- **功能描述**: 逼真的烟花升空爆炸效果，包含物理引擎和粒子系统
- **主要特性**:
  - 连续的烟花发射动画
  - 逼真的物理效果（重力、摩擦力）
  - 粒子拖尾效果
  - 随机颜色和爆炸模式
  - 可控制的开始/停止功能
- **使用方法**:
  - 点击"开始"按钮启动连续烟花动画
  - 点击"停止"按钮停止动画效果
  - 支持实时物理计算，约60fps流畅动画

### 📱 iOS风格设置界面 (AppEntryPage)
- **文件位置**: `lib/app/entry/app_entry.dart`
- **功能描述**: 仿iOS系统设置界面，提供优雅的列表式导航体验
- **主要特性**:
  - iOS风格的分组列表布局
  - 圆角卡片和阴影效果
  - FontAwesome图标支持
  - 流畅的页面转场动画
  - 数据驱动的动态列表
  - 自定义导航和点击响应
- **使用方法**:
  - 通过数组配置列表项目和分组
  - 支持自定义图标、颜色和副标题
  - 点击列表项自动导航到详情页面
  - 完全响应式设计，适配不同屏幕尺寸

### 🎬 其他应用模块
- **动画文本应用**: 各种文本动画效果
- **媒体播放器**: 视频播放功能
- **变形动画**: Box Transform 动画效果
- **液体滑动**: Liquid Swipe 页面切换效果
- **电影应用**: 包含图片轮播和详情页面

## 技术架构

### 核心技术栈
- **Flutter框架**: 3.27.4 版本
- **Material Design 3**: 现代化UI设计
- **自定义绘制**: CustomPainter 实现复杂图形
- **动画系统**: AnimationController + CustomPaint
- **状态管理**: StatefulWidget + Provider

### 烟花应用技术细节
- **物理引擎**: 自定义重力和摩擦力系统
- **粒子系统**: 支持拖尾效果和Alpha渐变
- **性能优化**: 限制最大粒子和烟花数量
- **混合模式**: BlendMode.plus 实现发光效果
- **定时器管理**: Timer.periodic 控制发射频率

## Getting Started

### 环境要求
- Flutter SDK 3.27.4+
- Dart 3.0+
- Android Studio 或 VS Code

### 运行项目
```bash
flutter pub get
flutter run
```

### 运行特定应用
要运行烟花应用，请确保 main.dart 中引用了 FireworksApp。

## 学习资源

- [Flutter官方文档](https://docs.flutter.dev/)
- [Material Design 3](https://m3.material.io/)
- [Flutter动画指南](https://docs.flutter.dev/development/ui/animations)
- [CustomPainter教程](https://docs.flutter.dev/cookbook/effects/custom-painter)
