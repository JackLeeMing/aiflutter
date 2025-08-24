import 'package:aiflutter/pages/images/image_selector.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'utils/platform.dart';

List<ImageProvider> get assetsImage => [
      'assets/images/home_1.png',
      'assets/images/home_2.png',
      'assets/images/good_boys.jpg',
      'assets/images/joker.png',
      'assets/images/lion_king.jpg',
      'assets/images/the_irishman.jpg',
    ].map((e) => AssetImage(e)).toList();

void runTablet() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
  int? _activeIndex;
  ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.purple);
  Color activeColor = Colors.white;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    // 提取所有颜色属性
    final allColors = [
      _ColorInfo(name: 'primary', color: scheme.primary),
      _ColorInfo(name: 'onPrimary', color: scheme.onPrimary),
      _ColorInfo(name: 'primaryContainer', color: scheme.primaryContainer),
      _ColorInfo(name: 'onPrimaryContainer', color: scheme.onPrimaryContainer),
      _ColorInfo(name: 'secondary', color: scheme.secondary),
      _ColorInfo(name: 'onSecondary', color: scheme.onSecondary),
      _ColorInfo(name: 'secondaryContainer', color: scheme.secondaryContainer),
      _ColorInfo(name: 'onSecondaryContainer', color: scheme.onSecondaryContainer),
      _ColorInfo(name: 'tertiary', color: scheme.tertiary),
      _ColorInfo(name: 'onTertiary', color: scheme.onTertiary),
      _ColorInfo(name: 'tertiaryContainer', color: scheme.tertiaryContainer),
      _ColorInfo(name: 'onTertiaryContainer', color: scheme.onTertiaryContainer),
      _ColorInfo(name: 'error', color: scheme.error),
      _ColorInfo(name: 'onError', color: scheme.onError),
      _ColorInfo(name: 'errorContainer', color: scheme.errorContainer),
      _ColorInfo(name: 'onErrorContainer', color: scheme.onErrorContainer),
      _ColorInfo(name: 'surface', color: scheme.surface),
      _ColorInfo(name: 'onSurface', color: scheme.onSurface),
      _ColorInfo(name: 'surfaceContainer', color: scheme.surfaceContainer),
      _ColorInfo(name: 'onSurfaceVariant', color: scheme.onSurfaceVariant),
      _ColorInfo(name: 'inverseSurface', color: scheme.inverseSurface),
      _ColorInfo(name: 'onInverseSurface', color: scheme.onInverseSurface),
      _ColorInfo(name: 'background', color: scheme.background),
      _ColorInfo(name: 'onBackground', color: scheme.onBackground),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: WindowFrameWidget(
          child: Scaffold(
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: allColors
                        .map((e) => _ColorBlock(
                              name: e.name,
                              color: e.color,
                            ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              buildImageSelector(),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildImageSelector() {
    return Container(
        width: 108,
        padding: EdgeInsets.only(right: 8, top: 8),
        child: ImageSelector(
          images: assetsImage,
          indicatorColor: scheme.primary,
          onIndexChange: _onImageChange,
          activeIndex: _activeIndex,
        ));
  }

  void _onImageChange(int index) async {
    setState(() {
      _activeIndex = index;
    });
    ImageProvider image = assetsImage[index];
    scheme = await ColorScheme.fromImageProvider(provider: image);
    activeColor = scheme.primary;
    setState(() {});
  }
}

class _ColorInfo {
  final String name;
  final Color color;

  _ColorInfo({required this.name, required this.color});
}

class ColorSection extends StatelessWidget {
  final String title;
  final List<_ColorInfo> colors;

  const ColorSection({super.key, required this.title, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: colors
                .map((e) => _ColorBlock(
                      name: e.name,
                      color: e.color,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ColorBlock extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorBlock({
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final hexCode = '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                color: _getContrastColor(color),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              hexCode,
              style: TextStyle(
                color: _getContrastColor(color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getContrastColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
