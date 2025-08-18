import 'package:aiflutter/utils/loggerUtil.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
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
  String videpType = "1";
  final videoUrlMap = {
    // 'flv': 'https://www.sensorcmd.com/video6/rtp/34020000001110000016_61062900041317000010.live.flv?vip=smart_guy',
    // 'hls': 'https://www.sensorcmd.com/video6/rtp/34020000001110000016_61062900041317000010/hls.m3u8?vip=smart_guy',
    // 'mp4': 'https://www.sensorcmd.com/video6/rtp/34020000001110000016_61062900041317000010.live.mp4?vip=smart_guy',
    '1': 'https://vip2.bfbfhao.com/20240903/OZg8crY7/hls/index.m3u8',
    '2': "https://vip2.bfbfhao.com/20240913/cGLd1q51/hls/index.m3u8",
    '3': "https://vip2.bfbfhao.com/20240914/388lfPiu/hls/index.m3u8",
    '4': 'https://vip2.bfbfhao.com/20240913/MBjgVBJq/hls/index.m3u8',
    '5': 'https://vip2.bfbfhao.com/20240913/lOjnrmsn/hls/index.m3u8',
    '6': 'https://vip6.ddyunbo.com/20240910/kIyqPhIz/hls/index.m3u8',
    '7': 'https://vip2.bfbfhao.com/20240909/NMFKBdqW/hls/index.m3u8',
    '8': 'https://vip2.bfbfhao.com/20240910/2Y6Hutzv/hls/index.m3u8',
    '9': 'https://vip6.ddyunbo.com/20240907/Pxomqnwv/hls/index.m3u8',
    '10': "https://vip4.ddyunbo.com/20240901/NdUf3Ber/hls/index.m3u8",
    '11': 'https://vip4.ddyunbo.com/20240907/B2hmn2Me/hls/index.m3u8',
    '12': 'https://vip2.bfbfhao.com/20240915/UR0A86c4/hls/index.m3u8'
  };

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
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
          appBar: AppBar(
            title: Text("Media Kit"),
            centerTitle: true,
            foregroundColor: Colors.white,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(color: Colors.pink, width: 1)),
            ),
          ),
          body: Center(
              child: Column(
            children: [
              Text(
                videpType,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              buildGrid(),
              SizedBox(height: 16),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 500,
                child: Video(controller: controller),
              )
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (isPlaying) {
                  player.pause();
                } else {
                  player.open(
                    Media(videoUrlMap[videpType]!),
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

  Widget buildGrid() {
    List<String> keysList = videoUrlMap.keys.toList();
    List<Widget> widgets = List.generate(keysList.length, (int index) {
      final number = keysList[index];
      bool isSel = videpType == number;
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSel ? Colors.red : Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          width: 25,
          height: 25,
          margin: EdgeInsets.all(1),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          setState(() {
            videpType = number;
          });
        },
      );
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [...widgets],
    );
  }
}
