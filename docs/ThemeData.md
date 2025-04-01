# Flutter ThemeData 详解

Flutter 的 `ThemeData` 类是管理应用程序主题的核心，它允许开发者定义应用的整体视觉风格。本文档详细介绍 `ThemeData` 的主要属性及其作用。

## 基础属性

### brightness

```dart
brightness: Brightness.light
```

控制应用的整体明暗主题：
- `Brightness.light`：亮色/日间模式，浅色背景、深色文字
- `Brightness.dark`：暗色/夜间模式，深色背景、浅色文字

此设置会影响许多默认颜色，如文本、图标、背景等。

### primarySwatch

```dart
primarySwatch: Colors.blue
```

定义应用的主色调色板，是一组相关的颜色。Flutter 会自动生成不同深浅的颜色变体，用于各种界面元素。常用的预定义色板有：`Colors.blue`、`Colors.red`、`Colors.green` 等。

### primaryColor

```dart
primaryColor: Colors.indigo
```

应用的主要颜色，用于 AppBar 背景、TabBar 等主要部件。如果同时设置了 `primarySwatch`，此属性会覆盖由 `primarySwatch` 推导出的主色。

### accentColor / colorScheme.secondary

```dart
// Flutter 2.0 之前
accentColor: Colors.pinkAccent

// Flutter 2.0 之后
colorScheme: ColorScheme.light(
  secondary: Colors.pinkAccent,
)
```

定义应用的强调色，用于浮动操作按钮、选中状态等需要突出显示的元素。

## 布局和视觉密度

### visualDensity

```dart
visualDensity: VisualDensity.adaptivePlatformDensity
```

控制 UI 元素的紧凑程度：
- `VisualDensity.adaptivePlatformDensity`：根据平台自动调整
- `VisualDensity.comfortable`：更宽松的布局
- `VisualDensity.compact`：更紧凑的布局
- 自定义：`VisualDensity(horizontal: 0.0, vertical: -1.0)`

### materialTapTargetSize

```dart
materialTapTargetSize: MaterialTapTargetSize.padded
```

定义 Material 组件的最小点击区域大小：
- `MaterialTapTargetSize.padded`：标准大小（默认）
- `MaterialTapTargetSize.shrinkWrap`：较小的点击区域

## 颜色相关属性

### scaffoldBackgroundColor

```dart
scaffoldBackgroundColor: Colors.white
```

Scaffold 组件的背景色，通常是应用的主要背景颜色。

### backgroundColor

```dart
backgroundColor: Colors.grey[200]
```

各种 Material 组件的背景颜色，如 Card, Dialog 等。

### cardColor

```dart
cardColor: Colors.white
```

Card 组件的背景颜色。

### dividerColor

```dart
dividerColor: Colors.grey[300]
```

Divider 和其他分隔线的颜色。

### errorColor

```dart
errorColor: Colors.red
```

错误状态的颜色，如表单验证错误提示。

### colorScheme

```dart
colorScheme: ColorScheme.light(
  primary: Colors.blue,
  secondary: Colors.cyan,
  surface: Colors.white,
  background: Colors.grey[50],
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black87,
  onBackground: Colors.black87,
  onError: Colors.white,
  brightness: Brightness.light,
)
```

定义一套完整的颜色方案，是 Material Design 2.0 引入的更全面的颜色体系。

## 文本样式

### textTheme

```dart
textTheme: TextTheme(
  headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.w300),
  headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w300),
  headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400),
  headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400),
  headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
  headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
  subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
  subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
  bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
  bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
  button: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
  caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
  overline: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),
)
```

定义应用中各种文本样式，按用途分类。

### primaryTextTheme

```dart
primaryTextTheme: TextTheme(
  headline6: TextStyle(color: Colors.white),
)
```

与主色背景搭配使用的文本主题，通常用于 AppBar 上的文本。

### fontFamily

```dart
fontFamily: 'Roboto'
```

应用的默认字体。

## 组件样式

### appBarTheme

```dart
appBarTheme: AppBarTheme(
  color: Colors.blue,
  elevation: 4.0,
  centerTitle: false,
  brightness: Brightness.dark,
)
```

自定义 AppBar 组件的默认样式。

### buttonTheme

```dart
buttonTheme: ButtonThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  buttonColor: Colors.blue,
  textTheme: ButtonTextTheme.primary,
)
```

按钮的默认样式（用于旧式按钮）。

### elevatedButtonTheme / textButtonTheme / outlinedButtonTheme

```dart
elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    primary: Colors.blue,
    onPrimary: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
)
```

新版按钮组件的样式。

### inputDecorationTheme

```dart
inputDecorationTheme: InputDecorationTheme(
  border: OutlineInputBorder(),
  filled: true,
  fillColor: Colors.grey[100],
)
```

文本输入框的默认装饰样式。

### cardTheme

```dart
cardTheme: CardTheme(
  elevation: 2.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
)
```

Card 组件的默认样式。

### floatingActionButtonTheme

```dart
floatingActionButtonTheme: FloatingActionButtonThemeData(
  backgroundColor: Colors.orange,
  foregroundColor: Colors.white,
  elevation: 6.0,
)
```

浮动操作按钮的默认样式。

### sliderTheme

```dart
sliderTheme: SliderThemeData(
  activeTrackColor: Colors.blue,
  thumbColor: Colors.blue,
  valueIndicatorColor: Colors.blue,
)
```

Slider 滑块组件的样式。

### switchTheme

```dart
switchTheme: SwitchThemeData(
  thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.blue;
    }
    return Colors.grey;
  }),
  trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.blue.withOpacity(0.5);
    }
    return Colors.grey.withOpacity(0.5);
  }),
)
```

Switch 开关组件的样式。

### tabBarTheme

```dart
tabBarTheme: TabBarTheme(
  labelColor: Colors.white,
  unselectedLabelColor: Colors.white70,
  indicator: UnderlineTabIndicator(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
)
```

TabBar 选项卡的样式。

### dialogTheme

```dart
dialogTheme: DialogTheme(
  backgroundColor: Colors.white,
  elevation: 24.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
  ),
)
```

对话框的样式。

### bottomNavigationBarTheme

```dart
bottomNavigationBarTheme: BottomNavigationBarThemeData(
  backgroundColor: Colors.white,
  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,
)
```

底部导航栏的样式。

## 动画和装饰

### pageTransitionsTheme

```dart
pageTransitionsTheme: PageTransitionsTheme(
  builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
)
```

定义页面切换动画。

### splashFactory

```dart
splashFactory: InkRipple.splashFactory
```

定义 Material 组件点击水波纹效果。

### iconTheme

```dart
iconTheme: IconThemeData(
  color: Colors.black87,
  size: 24.0,
)
```

图标的默认样式。

### primaryIconTheme

```dart
primaryIconTheme: IconThemeData(
  color: Colors.white,
)
```

在主色背景上使用的图标样式。

## 主题使用示例

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Theme Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
        
        // 颜色相关
        scaffoldBackgroundColor: Colors.grey[50],
        
        // 文本样式
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
        
        // 组件样式
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        
        cardTheme: CardTheme(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: EdgeInsets.all(8.0),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        // 其他暗色主题配置...
      ),
      themeMode: ThemeMode.system, // 根据系统设置自动切换明暗主题
      home: MyHomePage(),
    );
  }
}
```

## 如何使用主题

### 获取当前主题

```dart
final theme = Theme.of(context);
final primaryColor = theme.primaryColor;
final bodyTextStyle = theme.textTheme.bodyText2;
```

### 创建继承主题

```dart
Theme(
  data: Theme.of(context).copyWith(
    colorScheme: Theme.of(context).colorScheme.copyWith(
      secondary: Colors.green,
    ),
  ),
  child: Builder(
    builder: (context) {
      return FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      );
    },
  ),
)
```

### 响应主题变化

```dart
class _MyWidgetState extends State<MyWidget> with WidgetsBindingObserver {
  @override
  void didChangePlatformBrightness() {
    setState(() {
      // 平台亮度变化时更新UI
    });
    super.didChangePlatformBrightness();
  }
}
```

## 最佳实践

1. **使用主题扩展**：在 Flutter 3.0+ 中，可以使用 `ThemeExtension` 创建自定义主题扩展。

   ```dart
   class MyThemeExtension extends ThemeExtension<MyThemeExtension> {
     final Color specialColor;
     
     MyThemeExtension({required this.specialColor});
     
     @override
     ThemeExtension<MyThemeExtension> copyWith({Color? specialColor}) {
       return MyThemeExtension(
         specialColor: specialColor ?? this.specialColor,
       );
     }
     
     @override
     ThemeExtension<MyThemeExtension> lerp(ThemeExtension<MyThemeExtension>? other, double t) {
       if (other is! MyThemeExtension) {
         return this;
       }
       return MyThemeExtension(
         specialColor: Color.lerp(specialColor, other.specialColor, t)!,
       );
     }
   }
   
   // 使用扩展
   final theme = ThemeData(
     extensions: [
       MyThemeExtension(specialColor: Colors.purple),
     ],
   );
   
   // 获取扩展
   final myExtension = Theme.of(context).extension<MyThemeExtension>();
   final specialColor = myExtension?.specialColor;
   ```

2. **颜色和字体的集中管理**：创建专门的颜色和字体类，便于维护。

3. **亮暗主题兼容性**：设计时考虑亮暗两种主题，确保两种模式下都有良好的可读性和美观度。

4. **响应式主题**：考虑不同设备尺寸下的视觉效果，使用 `MediaQuery` 在不同设备上调整字体大小和间距。

## 总结

`ThemeData` 是 Flutter 应用程序风格的核心，它提供了丰富的选项来统一定制应用的外观。良好的主题设计不仅能提升用户体验，还能简化开发过程，减少重复代码。推荐在开发初期就建立完善的主题系统，以便于后期的维护和拓展。