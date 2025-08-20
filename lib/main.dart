import 'dart:io';

// import 'package:aiflutter/app/mediaKitApp/firework_app.dart';
// import 'package:aiflutter/app/mediaKitApp/digit_clock_app.dart';
// import 'package:aiflutter/app/dartPad/dart_pad.dart';
import 'package:aiflutter/utils/loggerUtil.dart';
import 'package:aiflutter/utils/package_info.dart';
import 'package:aiflutter/utils/platform.dart';
import 'package:aiflutter/utils/util.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:animations/animations.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:toastification/toastification.dart';
import 'package:aiflutter/app/entry/app_entry.dart';

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
      child: MaterialApp(
        title: 'TestApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              // TargetPlatform.android: PredictiveBackPageTransitionsBuilder(), // NEW
              //  TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(), // NEW
              TargetPlatform.macOS: FadeThroughPageTransitionsBuilder(), // NEW
              TargetPlatform.windows: FadeThroughPageTransitionsBuilder(), // NEW
              TargetPlatform.linux: FadeThroughPageTransitionsBuilder(), // NEW
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        home: WindowFrameWidget(
          child: AppEntryPage(),
        ),
      ),
    );
  }
}
