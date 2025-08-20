import 'dart:io';

// import 'package:aiflutter/app/mediaKitApp/firework_app.dart';
// import 'package:aiflutter/app/mediaKitApp/digit_clock_app.dart';
// import 'package:aiflutter/app/dartPad/dart_pad.dart';
import 'package:aiflutter/utils/loggerUtil.dart';
import 'package:aiflutter/utils/package_info.dart';
import 'package:aiflutter/utils/platform.dart';
import 'package:aiflutter/utils/util.dart';
import 'package:animations/animations.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:toastification/toastification.dart';
import 'package:aiflutter/router/app_router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration.zero);
  await Util.initStorageDir();
  await initPackageInfo();
  initLogger();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    Phoenix(
      child: const AIFlutterApp(),
    ),
  );
  // 设置窗口大小（仅限桌面平台）
  if (PlatformTool.isDesktop()) {
    doWhenWindowReady(() {
      const initialSize = Size(600, 800);
      appWindow.minSize = initialSize;
      appWindow.maxSize = Size(800, 800);
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

class AIFlutterApp extends StatefulWidget {
  const AIFlutterApp({super.key});

  @override
  State<StatefulWidget> createState() => _AIFlutterAppState();
}

class _AIFlutterAppState extends State<AIFlutterApp> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
    }
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'AI Flutter',
        debugShowCheckedModeBanner: false,

        // 使用 Go Router 配置
        routerConfig: AppRouter.router,

        // Material Design 3 主题
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,

          // 现代化的 AppBar 样式
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 1,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),

          // 页面转场动画
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.macOS: FadeThroughPageTransitionsBuilder(),
              TargetPlatform.windows: FadeThroughPageTransitionsBuilder(),
              TargetPlatform.linux: FadeThroughPageTransitionsBuilder(),
            },
          ),

          // 卡片样式
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          // 按钮样式
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ),

        // 深色主题
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),

        // 主题模式
        themeMode: ThemeMode.system,
      ),
    );
  }
}
