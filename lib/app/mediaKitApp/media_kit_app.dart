import 'package:aiflutter/utils/loggerUtil.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MediaKitPlayerPage extends StatefulWidget {
  const MediaKitPlayerPage({super.key});

  @override
  State<MediaKitPlayerPage> createState() => _MediaKitPlayerState();
}

class _MediaKitPlayerState extends State<MediaKitPlayerPage> {
  late final Player player = Player();
  late final VideoController controller = VideoController(player);
  bool isPlaying = false;
  String videoKey = "flv";
  final videoUrlMap = {
    'flv': 'https://www.sensorcmd.com/video6/rtp/34020000001110000016_61062900041317000010.live.flv?vip=smart_guy',
    'hls': 'https://www.sensorcmd.com/video6/rtp/34020000001110000016_61062900041317000010/hls.m3u8?vip=smart_guy',
    'mp4': 'https://www.sensorcmd.com/video6/rtp/34020000001110000016_61062900041317000010.live.mp4?vip=smart_guy',
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
      // logger.d('缓冲中: $buffering');
    });

    // 监听播放位置
    player.stream.position.listen((position) {
      // logger.d('播放位置: ${position.inSeconds}秒');
    });

    // 监听时长
    player.stream.duration.listen((duration) {
      // logger.d('总时长: ${duration.inSeconds}秒');
    });

    // 监听播放完成
    player.stream.completed.listen((completed) {
      // logger.d('播放完成: $completed');
    });

    // 监听错误
    player.stream.error.listen((error) {
      logger.d('播放错误: $error');
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      player.open(
        Media(videoUrlMap[videoKey]!),
      );
      player.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Media Kit"),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
          children: [
            buildGrid(),
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
                  Media(videoUrlMap[videoKey]!),
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
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void onItemClick(String number) {
    player.stop();
    setState(() {
      videoKey = number;
    });
    /*
    WidgetsBinding.instance.addPostFrameCallback 
    允许你注册一个回调函数，这个函数会在当前帧渲染完成后、
    UI 树重建之后立即被调用。这非常适合用来执行那些需要依赖于 UI 布局或渲染结果的操作
    */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      player.open(
        Media(videoUrlMap[number]!),
      );
      player.play();
    });
  }

  Widget buildGrid() {
    List<String> keysList = videoUrlMap.keys.toList();
    List<Widget> widgets = List.generate(keysList.length, (int index) {
      final number = keysList[index];
      bool isSel = videoKey == number;
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSel ? Colors.red : Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          width: 50,
          height: 25,
          margin: EdgeInsets.all(5),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () => onItemClick(number),
      );
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...widgets,
        SizedBox(width: 16),
        Text(
          videoKey,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
