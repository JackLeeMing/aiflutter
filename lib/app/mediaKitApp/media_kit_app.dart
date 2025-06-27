import 'package:aiflutter/utils/loggerUtil.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MediaKitPlayerApp extends StatefulWidget {
  const MediaKitPlayerApp({super.key});

  @override
  State<MediaKitPlayerApp> createState() => _MediaKitPlayerState();
}

class _MediaKitPlayerState extends State<MediaKitPlayerApp> {
  late final Player player = Player();
  late final VideoController controller = VideoController(player);
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    player.stream.playing.listen((playing) {
      setState(() {
        isPlaying = playing;
      });
    });
    // 监听缓冲状态
    player.stream.buffering.listen((buffering) {
      logger.d('缓冲中: $buffering');
    });

    // 监听播放位置
    player.stream.position.listen((position) {
      logger.d('播放位置: ${position.inSeconds}秒');
    });

    // 监听时长
    player.stream.duration.listen((duration) {
      logger.d('总时长: ${duration.inSeconds}秒');
    });

    // 监听播放完成
    player.stream.completed.listen((completed) {
      logger.d('播放完成: $completed');
    });

    // 监听错误
    player.stream.error.listen((error) {
      logger.d('播放错误: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediaKit Player App',
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
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: double.infinity,
              height: 350,
              child: Video(controller: controller),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (isPlaying) {
                  player.pause();
                } else {
                  player.open(
                    Media(
                        'https://www.sensorcmd.com/video6/rtp/34020000001110000016_61062900041317000010.live.mp4?vip=smart_guy'),
                  );
                  player.play();
                }
              });
            },
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
