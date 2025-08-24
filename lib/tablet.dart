import 'package:aiflutter/pages/images/image_selector.dart';
import 'package:aiflutter/utils/loggerUtil.dart';
import 'package:aiflutter/utils/package_info.dart';
import 'package:aiflutter/utils/util.dart';
import 'package:aiflutter/widgets/color_scheme_display.dart';
import 'package:aiflutter/widgets/triangle_painter.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:aiflutter/pages/firworks/heart.dart';

import 'utils/platform.dart';

List<ImageProvider> get assetsImage => [
      'assets/images/good_boys.jpg',
      'assets/images/joker.png',
      'assets/images/lion_king.jpg',
      'assets/images/the_irishman.jpg',
    ].map((e) => AssetImage(e)).toList();

void runTablet() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration.zero);
  await Util.initStorageDir();
  await initPackageInfo();
  initLogger();
  runApp(
    Phoenix(
      child: MyTabletApp(),
    ),
  );
  // 设置窗口大小（仅限桌面平台）
  if (PlatformTool.isDesktop()) {
    doWhenWindowReady(() {
      const initialSize = Size(900, 800);
      appWindow.minSize = initialSize;
      appWindow.maxSize = Size(1000, 1000);
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = "AI Flutter";
      if (PlatformTool.isWindows()) {
        WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
          appWindow.size = initialSize + const Offset(0, 1);
        });
      }
      appWindow.show();
    });
  }
  // FlutterNativeSplash.remove();
}

class MyTabletApp extends StatefulWidget {
  const MyTabletApp({super.key});

  @override
  State<MyTabletApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyTabletApp> {
  ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.purple);
  Color activeColor = Colors.cyan;
  int colorIndex = -1;

  @override
  void initState() {
    super.initState();
    activeColor = scheme.primary;
    FlutterNativeSplash.remove();
  }

  void _onColorSchemeChanged(ColorScheme newScheme, int index) {
    setState(() {
      scheme = newScheme;
      activeColor = newScheme.primary;
      colorIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 提取所有颜色属性
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme, // 使用动态的 ColorScheme
      ),
      home: WindowFrameWidget(
        child: MyTabletHomeScreen(
          initialColorScheme: scheme,
          onColorSchemeChanged: _onColorSchemeChanged,
          colorIndex: colorIndex,
        ),
      ),
    );
  }
}

class MyTabletHomeScreen extends StatefulWidget {
  final ColorScheme initialColorScheme;
  final Function(ColorScheme, int) onColorSchemeChanged;
  final int colorIndex;

  const MyTabletHomeScreen({
    super.key,
    required this.initialColorScheme,
    required this.onColorSchemeChanged,
    required this.colorIndex,
  });

  @override
  State<MyTabletHomeScreen> createState() => _MyTabletHomeScreenState();
}

class _MyTabletHomeScreenState extends State<MyTabletHomeScreen> {
  int? _activeIndex;
  late Color activeColor;

  @override
  void initState() {
    super.initState();
    activeColor = widget.initialColorScheme.primary;
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    // 提取所有颜色属性
    return Scaffold(
      appBar: AppBar(
        title: Text("ColorScheme 总览"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...List.generate(colors.length, (index) {
                        // 使用 Padding 替代 Sizedbox 来控制间隔
                        return InkWell(
                          onTap: () {
                            _onColorChange(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.5),
                            child: TriangleCorner(
                              triangleColor: widget.colorIndex == index ? Colors.pinkAccent : Colors.transparent,
                              position: TrianglePosition.left,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: colors[index],
                                  // borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  ColorSchemeDisplayWidget(
                    colorScheme: widget.initialColorScheme,
                    title: 'ColorScheme 总览',
                    onColorCopied: () {
                      logger.d('onColorCopied');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('颜色代码已复制到剪贴板'),
                          duration: Duration(seconds: 2),
                          backgroundColor: widget.initialColorScheme.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          buildImageSelector(),
        ],
      ),
    );
  }

  Widget buildImageSelector() {
    return Container(
      width: 102,
      padding: EdgeInsets.only(right: 2, top: 2),
      child: ImageSelector(
        images: assetsImage,
        indicatorColor: widget.initialColorScheme.primary,
        onIndexChange: _onImageChange,
        activeIndex: _activeIndex,
      ),
    );
  }

  void _onImageChange(int index) async {
    setState(() {
      _activeIndex = index;
    });
    ImageProvider image = assetsImage[index];
    ColorScheme scheme = await ColorScheme.fromImageProvider(provider: image);
    activeColor = scheme.primary;
    // 将新的 ColorScheme 回传给父组件
    widget.onColorSchemeChanged(scheme, -1);

    setState(() {});
  }

  void _onColorChange(int index) async {
    ColorScheme scheme = ColorScheme.fromSeed(seedColor: colors[index]);
    activeColor = scheme.primary;
    widget.onColorSchemeChanged(scheme, index);
    setState(() {});
  }
}
