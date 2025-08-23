import 'package:aiflutter/application/settings/widgets/gallery_screen.dart';
import 'package:aiflutter/utils/platform.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

/// Set to `true` to see the full possibilities of the iOS Developer Screen

void runSetting({bool runCupertinoApp = false}) {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (_) => MyApp(runCupertinoApp: runCupertinoApp),
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
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final bool runCupertinoApp;
  const MyApp({super.key, required this.runCupertinoApp});

  @override
  Widget build(BuildContext context) {
    if (runCupertinoApp) {
      return CupertinoApp(
        locale: Locale('zh', 'zh'), //DevicePreview.locale(context),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        title: 'Settings Cupertino UI Demo',
        home: WindowFrameWidget(child: GalleryScreen()),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: true,
        locale: Locale('zh', 'zh'), //DevicePreview.locale(context),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark().copyWith(
            cupertinoOverrideTheme: CupertinoThemeData(
                barBackgroundColor: Color(0xFF1b1b1b),
                brightness: Brightness.dark,
                textTheme: CupertinoTextThemeData(primaryColor: Colors.white)),
            brightness: Brightness.dark),
        title: 'Settings  Material UI Demo',
        home: WindowFrameWidget(child: GalleryScreen()),
      );
    }
  }
}
