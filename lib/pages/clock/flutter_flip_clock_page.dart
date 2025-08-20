import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:aiflutter/router/app_router.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

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
    if (Platform.isIOS || Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isLandscape = size.width > size.height;

    // 响应式尺寸计算
    double weight;
    double fontSize;
    double spacing;

    if (isTablet) {
      // 平板设备
      weight = isLandscape ? size.width * 0.12 : size.width * 0.2;
      fontSize = weight * 0.4;
      spacing = 15.0;
    } else {
      // 手机设备
      weight = isLandscape ? size.width * 0.15 : ((size.width - 40) / 3) - 10;
      fontSize = weight * 0.35;
      spacing = 8.0;
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
              SizedBox(height: 50),
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
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FlipPanel.stream(
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
                  _FlipPanel.stream(
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
                  _FlipPanel.stream(
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
            shape: CircleBorder(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.yellow,
            child: const Icon(Icons.arrow_back_sharp, color: Colors.white)),
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

/// Signature for a function that creates a widget for a given index, e.g., in a
/// list.
typedef Widget IndexedItemBuilder(BuildContext, int);

/// Signature for a function that creates a widget for a value emitted from a [Stream]
typedef Widget StreamItemBuilder<T>(BuildContext, T);

/// A widget for flip panel with built-in animation
/// Content of the panel is built from [IndexedItemBuilder] or [StreamItemBuilder]
///
/// Note: the content size should be equal

enum FlipDirection { up, down }

class _FlipPanel<T> extends StatefulWidget {
  final IndexedItemBuilder? indexedItemBuilder;
  final StreamItemBuilder<T>? streamItemBuilder;
  final Stream<T>? itemStream;
  final int itemsCount;
  final Duration? period;
  final Duration duration;
  final int loop;
  final int startIndex;
  final T? initValue;
  final double spacing;
  final FlipDirection direction;

  const _FlipPanel({
    super.key,
    this.indexedItemBuilder,
    this.streamItemBuilder,
    this.itemStream,
    required this.itemsCount,
    this.period,
    required this.duration,
    required this.loop,
    required this.startIndex,
    this.initValue,
    required this.spacing,
    required this.direction,
  });

  /// Create a flip panel from iterable source
  /// [itemBuilder] is called periodically in each time of [period]
  /// The animation is looped in [loop] times before finished.
  /// Setting [loop] to -1 makes flip animation run forever.
  /// The [period] should be two times greater than [duration] of flip animation,
  /// if not the animation becomes jerky/stuttery.
  // ignore: unused_element
  _FlipPanel.builder({
    super.key,
    required IndexedItemBuilder itemBuilder,
    required this.itemsCount,
    required this.period,
    this.duration = const Duration(milliseconds: 500),
    this.loop = 1,
    this.startIndex = 0,
    this.spacing = 0.5,
    this.direction = FlipDirection.down,
  })  : assert(startIndex < itemsCount),
        assert(period == null || period.inMilliseconds >= 2 * duration.inMilliseconds),
        indexedItemBuilder = itemBuilder,
        streamItemBuilder = null,
        itemStream = null,
        initValue = null;

  /// Create a flip panel from stream source
  /// [itemBuilder] is called whenever a new value is emitted from [itemStream]
  const _FlipPanel.stream({
    super.key,
    required this.itemStream,
    required StreamItemBuilder<T> itemBuilder,
    this.initValue,
    this.duration = const Duration(milliseconds: 500),
    this.spacing = 0.5,
    this.direction = FlipDirection.down,
  })  : indexedItemBuilder = null,
        streamItemBuilder = itemBuilder,
        itemsCount = 0,
        period = null,
        loop = 0,
        startIndex = 0;

  @override
  _FlipPanelState<T> createState() => _FlipPanelState<T>();
}

class _FlipPanelState<T> extends State<_FlipPanel<T>> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;
  bool _isReversePhase = false;
  bool _isStreamMode = false;
  bool _running = false;
  final double _perspective = 0.003;
  final double _zeroAngle = 0.0001;
  // There's something wrong in the perspective transform, I use a very small value instead of zero to temporarily get it around.
  int _loop = 0;
  T? _currentValue, _nextValue;
  Timer? _timer;
  StreamSubscription<T>? _subscription;

  Widget? _child1, _child2;
  Widget? _upperChild1, _upperChild2;
  Widget? _lowerChild1, _lowerChild2;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
    _isStreamMode = widget.itemStream != null;
    _isReversePhase = false;
    _running = false;
    _loop = 0;

    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isReversePhase = true;
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          _currentValue = _nextValue;
          _running = false;
        }
      })
      ..addListener(() {
        setState(() {
          _running = true;
        });
      });
    _animation = Tween(begin: _zeroAngle, end: math.pi / 2).animate(_controller);

    if (widget.period != null) {
      _timer = Timer.periodic(widget.period!, (_) {
        if (widget.loop < 0 || _loop < widget.loop) {
          if (_currentIndex + 1 == widget.itemsCount - 2) {
            _loop++;
          }
          _currentIndex = (_currentIndex + 1) % widget.itemsCount;
          _child1 = null;
          _isReversePhase = false;
          _controller.forward();
        } else {
          _timer?.cancel();
          _currentIndex = (_currentIndex + 1) % widget.itemsCount;
          setState(() {
            _running = false;
          });
        }
      });
    }

    if (_isStreamMode) {
      _currentValue = widget.initValue;
      _subscription = widget.itemStream?.distinct().listen((value) {
        if (_currentValue == null) {
          _currentValue = value;
        } else if (value != _currentValue) {
          _nextValue = value;
          _child1 = null;
          _isReversePhase = false;
          _controller.forward();
        }
      });
    } else if (widget.loop < 0 || _loop < widget.loop) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildChildWidgetsIfNeed(context);
    return _buildPanel();
  }

  void _buildChildWidgetsIfNeed(BuildContext context) {
    Widget makeUpperClip(Widget widget) {
      return ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 0.5,
          child: widget,
        ),
      );
    }

    Widget makeLowerClip(Widget widget) {
      return ClipRect(
        child: Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 0.5,
          child: widget,
        ),
      );
    }

    if (_running) {
      if (_child1 == null) {
        _child1 = _child2 ??
            (_isStreamMode
                ? widget.streamItemBuilder!(context, _currentValue as T)
                : widget.indexedItemBuilder!(context, _currentIndex % widget.itemsCount));
        _child2 = null;
        _upperChild1 = _upperChild2 ?? makeUpperClip(_child1!);
        _lowerChild1 = _lowerChild2 ?? makeLowerClip(_child1!);
      }
      if (_child2 == null) {
        _child2 = _isStreamMode
            ? widget.streamItemBuilder!(context, _nextValue as T)
            : widget.indexedItemBuilder!(context, (_currentIndex + 1) % widget.itemsCount);
        _upperChild2 = makeUpperClip(_child2!);
        _lowerChild2 = makeLowerClip(_child2!);
      }
    } else {
      _child1 = _child2 ??
          (_isStreamMode
              ? widget.streamItemBuilder!(context, _currentValue as T)
              : widget.indexedItemBuilder!(context, _currentIndex % widget.itemsCount));
      _upperChild1 = _upperChild2 ?? makeUpperClip(_child1!);
      _lowerChild1 = _lowerChild2 ?? makeLowerClip(_child1!);
    }
  }

  Widget _buildUpperFlipPanel() => widget.direction == FlipDirection.up
      ? Stack(
          children: [
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_zeroAngle),
              child: _upperChild1,
            ),
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase ? _animation.value : math.pi / 2),
              child: _upperChild2,
            ),
          ],
        )
      : Stack(
          children: [
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_zeroAngle),
              child: _upperChild2,
            ),
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase ? math.pi / 2 : _animation.value),
              child: _upperChild1,
            ),
          ],
        );

  Widget _buildLowerFlipPanel() => widget.direction == FlipDirection.up
      ? Stack(
          children: [
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_zeroAngle),
              child: _lowerChild2,
            ),
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase ? math.pi / 2 : -_animation.value),
              child: _lowerChild1,
            )
          ],
        )
      : Stack(
          children: [
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_zeroAngle),
              child: _lowerChild1,
            ),
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase ? -_animation.value : math.pi / 2),
              child: _lowerChild2,
            )
          ],
        );

  Widget _buildPanel() {
    return _running
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildUpperFlipPanel(),
              Padding(
                padding: EdgeInsets.only(top: widget.spacing),
              ),
              _buildLowerFlipPanel(),
            ],
          )
        : _isStreamMode && _currentValue == null
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, _perspective)
                        ..rotateX(_zeroAngle),
                      child: _upperChild1),
                  Padding(
                    padding: EdgeInsets.only(top: widget.spacing),
                  ),
                  Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, _perspective)
                        ..rotateX(_zeroAngle),
                      child: _lowerChild1)
                ],
              );
  }
}
