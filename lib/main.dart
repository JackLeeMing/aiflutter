import 'dart:io';

import 'package:aiflutter/app/animationApp/home_screen.dart';
import 'package:aiflutter/utils/platform.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await await Future.delayed(Duration.zero);
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
        ),
        home: WindowFrameWidget(
          child: AnimationHomeScreen(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.yellow,
            Colors.orange,
          ],
        ),
      ),
      child: Center(
        child: Text(
          "JackLeeMing",
          style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  @override
  void didChangeMetrics() {
    print("--- didChangeMetrics ---");
    super.didChangeMetrics();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
}
