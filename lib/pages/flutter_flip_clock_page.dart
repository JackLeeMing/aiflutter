import 'dart:async';
import 'dart:io';

import 'package:aiflutter/router/context_extension.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'clock/widgets.dart';

class FlutterFlipClockPage extends StatefulWidget {
  const FlutterFlipClockPage({super.key});

  @override
  State<FlutterFlipClockPage> createState() => _FlutterFlipClockState();
}

class _FlutterFlipClockState extends State<FlutterFlipClockPage> with WidgetsBindingObserver {
  String fixed(int n) {
    String s = n.toString();
    if (n < 10) {
      s = '0$s';
    }
    return s;
  }

  final StreamController<int> _second = StreamController<int>();
  final StreamController<int> _minute = StreamController<int>();
  final StreamController<int> _hour = StreamController<int>();

  int _year = DateTime.now().year;
  int _week = DateTime.now().weekday;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;

  @override
  void initState() {
    if (Platform.isIOS || Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 86, 46, 244), // 透明状态栏
        statusBarIconBrightness: Brightness.light, // Android
        statusBarBrightness: Brightness.light, // iOS
      ),
    );
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    WakelockPlus.enable();
    Timer.periodic(Duration(seconds: 1), (_) {
      var dt = DateTime.now();
      int sec = dt.second;
      _second.add(sec);
      if (sec == 0) {
        int min = dt.minute;
        _minute.add(min);
        if (min == 0) {
          int h = dt.hour;
          _hour.add(h);
          if (h == 0) {
            setState(() {
              _year = dt.year;
              _week = dt.weekday;
              _month = dt.month;
              _day = dt.day;
            });
          }
        }
      }
    });
  }

  void goBack() {
    context.goBack();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isLandscape = size.width > size.height;
    var isMobile = Platform.isAndroid || Platform.isIOS;

    // 响应式尺寸计算
    double weight;
    double fontSize;
    double spacing = 3;

    if (isTablet) {
      // 平板设备
      weight = isLandscape ? size.width * 0.12 : size.width * 0.2;
      fontSize = weight * 0.4;
    } else {
      // 手机设备
      weight = isLandscape ? size.width * 0.15 : ((size.width - 40) / 3) - 10;
      fontSize = weight * 0.35;
    }

    // 确保最小和最大尺寸
    weight = weight.clamp(150.0, 250.0);
    fontSize = fontSize.clamp(60.0, 120.0);

    final weeks = ['一', '二', '三', '四', '五', '六', '日'];
    return WindowFrameWidget(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          color: Color.fromARGB(255, 86, 46, 244),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: isMobile ? 50 : 80),
              // 日期信息行，响应式布局
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: isTablet ? 20.0 : 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildDateText('星期${weeks[_week - 1]}', fontSize * 0.55),
                    _buildDateText('$_year年$_month月$_day日', fontSize * 0.35),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 5 : 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlipPanel.stream(
                    initValue: DateTime.now().hour,
                    itemStream: _hour.stream,
                    itemBuilder: (context, v) => Container(
                      alignment: Alignment.center,
                      width: weight,
                      height: weight,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(41, 41, 41, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Text(
                        fixed(v),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: Colors.white),
                      ),
                    ),
                    spacing: spacing * 0.3,
                  ),
                  SizedBox(width: spacing),
                  FlipPanel.stream(
                    initValue: DateTime.now().minute,
                    itemStream: _minute.stream,
                    itemBuilder: (context, v) => Container(
                      alignment: Alignment.center,
                      width: weight,
                      height: weight,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(41, 41, 41, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Text(
                        fixed(v),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: Colors.white),
                      ),
                    ),
                    spacing: spacing * 0.3,
                  ),
                  SizedBox(width: spacing),
                  FlipPanel.stream(
                    initValue: DateTime.now().second,
                    itemStream: _second.stream,
                    itemBuilder: (context, v) => Container(
                      alignment: Alignment.center,
                      width: weight,
                      height: weight,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(41, 41, 41, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Text(
                        fixed(v),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: Colors.white),
                      ),
                    ),
                    spacing: spacing * 0.3,
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => goBack(),
          tooltip: '返回',
          mini: true,
          elevation: 4,
          shape: CircleBorder(),
          backgroundColor: Color.fromARGB(255, 63, 24, 222),
          foregroundColor: Colors.yellow,
          child: const Icon(Icons.arrow_back_sharp, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }

  // 构建日期文本的辅助方法
  Widget _buildDateText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    // print("--didChangeAppLifecycleState--" + state.toString());
    switch (state) {
      case AppLifecycleState.resumed:
        var dt = DateTime.now();
        setState(() {
          _year = dt.year;
          _week = dt.weekday;
          _month = dt.month;
          _day = dt.day;
          _hour.add(dt.hour);
          _minute.add(dt.minute);
          _second.add(dt.second);
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // 处理其他状态
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    if (Platform.isIOS || Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    super.dispose();
  }
}
