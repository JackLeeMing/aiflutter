import 'dart:io';

// import 'package:aiflutter/app/dismiss_page_app.dart'; // 轮播图+点击项目进入详情页，详情页可以滑动关闭消失
// import 'package:aiflutter/app/movieApp/movie_app_home.dart'; // 适合做有限数量的带图片的项目选择器
// import 'package:aiflutter/app/flutter_liquid_swipe_app.dart'; // LiquidSwipeApp
import 'package:aiflutter/app/liquid_swipe_app.dart'; // WithBuilderApp
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    Phoenix(
      child: const Main(),
    ),
  );
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }
  FlutterNativeSplash.remove();
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: WithBuilderApp(),
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
