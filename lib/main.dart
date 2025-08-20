import 'dart:io';
import 'dart:math';

// import 'package:aiflutter/app/mediaKitApp/firework_app.dart';
import 'package:aiflutter/app/mediaKitApp/digit_clock_app.dart';
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

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration.zero);
  await Util.initStorageDir();
  await initPackageInfo();
  initLogger();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    Phoenix(
      child: const DigitClockApp(),
    ),
  );
  // 设置窗口大小（仅限桌面平台）
  if (PlatformTool.isDesktop()) {
    doWhenWindowReady(() {
      const initialSize = Size(520, 520);
      appWindow.minSize = initialSize;
      appWindow.maxSize = Size(800, 520);
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
              TargetPlatform.android: PredictiveBackPageTransitionsBuilder(), // NEW
              TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(), // NEW
              TargetPlatform.macOS: FadeThroughPageTransitionsBuilder(), // NEW
              TargetPlatform.windows: FadeThroughPageTransitionsBuilder(), // NEW
              TargetPlatform.linux: FadeThroughPageTransitionsBuilder(), // NEW
            },
          ),
        ),
        home: WindowFrameWidget(
          child: StaggeredAnimationExample(),
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  bool _isBig = false;
  late AnimationController _controller;
  late Animation<double> _animationTurns;
  late Animation<double> _animationAngle;
  late Animation<Color?> _colorAnimation;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    // 2秒内 2圈
    _animationTurns = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    // 2秒内 0 到 4PI
    _animationAngle = Tween<double>(begin: 0, end: 4 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    // 颜色动画
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NextPage(),
                    ),
                  );
                },
                child: Hero(
                  tag: "imageTag",
                  child: Image.asset(
                    "assets/app.png",
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              Text("Implicit Animations 隐式动画"),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                width: _isBig ? 200 : 100,
                height: _isBig ? 200 : 100,
                color: _isBig ? Colors.red : Colors.blue,
                child: AnimatedOpacity(
                  opacity: _isBig ? 1.0 : 0.0,
                  duration: Duration(seconds: 1),
                  child: Image.asset(
                    "assets/app.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              AnimatedPadding(
                padding: _isBig ? EdgeInsets.all(10) : EdgeInsets.all(50),
                duration: Duration(seconds: 1),
                child: Text("Hello"),
              ),
              Text("Explicit Animations 显式动画"),
              AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return Container(
                    width: 200,
                    height: 200,
                    color: _colorAnimation.value,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animationTurns,
                builder: (context, child) {
                  return RotationTransition(
                    turns: _animationTurns, //圈数
                    child: child,
                  );
                },
                // 提供静态 widget
                child: FlutterLogo(size: 100),
              ),
              AnimatedBuilder(
                animation: _animationAngle,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animationAngle.value, // 角度
                    child: child,
                  );
                },
                // 提供静态 widget
                child: FlutterLogo(size: 100),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isBig = !_isBig;
            if (_controller.isAnimating) {
              _controller.stop();
            } else {
              _controller.repeat();
            }
          });
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: "imageTag",
              child: Image.asset(
                "assets/app.png",
                width: 400,
                height: 400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StaggeredAnimationExample extends StatefulWidget {
  const StaggeredAnimationExample({super.key});

  @override
  State<StaggeredAnimationExample> createState() => _StaggeredAnimationExampleState();
}

class _StaggeredAnimationExampleState extends State<StaggeredAnimationExample> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _width;
  late Animation<double> _height;
  late Animation<EdgeInsets> _padding;
  late Animation<BorderRadius?> _borderRadius;
  late Animation<Color?> _color;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.25, curve: Curves.easeIn),
    ));

    _width = Tween<double>(
      begin: 50,
      end: 150,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.125, 0.375, curve: Curves.easeOut),
    ));

    _height = Tween<double>(
      begin: 50,
      end: 150,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.25, 0.5, curve: Curves.easeOut),
    ));

    _padding = EdgeInsetsTween(
      begin: EdgeInsets.only(bottom: 16),
      end: EdgeInsets.only(bottom: 75),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.375, 0.625, curve: Curves.easeOut),
    ));

    _borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(4),
      end: BorderRadius.circular(75),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 0.75, curve: Curves.easeOut),
    ));

    _color = ColorTween(
      begin: Colors.indigo[100],
      end: Colors.orange[400],
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.625, 1.0, curve: Curves.easeOut),
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              padding: _padding.value,
              alignment: Alignment.center,
              child: Opacity(
                opacity: _opacity.value,
                child: Container(
                  width: _width.value,
                  height: _height.value,
                  decoration: BoxDecoration(
                    color: _color.value,
                    borderRadius: _borderRadius.value,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
