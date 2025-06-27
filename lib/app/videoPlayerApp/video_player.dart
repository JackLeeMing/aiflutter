import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoPlayerApp extends StatefulWidget {
  const VideoPlayerApp({super.key});

  @override
  State<VideoPlayerApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoPlayerApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://www.sensorcmd.com/video6/rtp/34020000001110000016_61062900041317000010.live.mp4?vip=smart_guy'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player App',
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
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
