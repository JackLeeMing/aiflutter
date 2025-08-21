import 'package:flutter/material.dart';
import 'package:flutter_liquid_swipe/flutter_liquid_swipe.dart';

class LiquidSwipeApp extends StatelessWidget {
  const LiquidSwipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LiquidSwipeOnboarding());
  }
}

class LiquidSwipeOnboarding extends StatefulWidget {
  const LiquidSwipeOnboarding({super.key});

  @override
  State<LiquidSwipeOnboarding> createState() => _LiquidSwipeOnboardingState();
}

class _LiquidSwipeOnboardingState extends State<LiquidSwipeOnboarding> {
  final _key = GlobalKey<LiquidSwipeState>();

  LiquidSwipeState? get liquidSwipeController => _key.currentState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidSwipe(key: _key, children: [
      FlutterLiquidSwipeCard(
          onTapName: () {},
          onSkip: () {},
          name: "Transcribe",
          action: "Skip",
          title: "SpeakEasy",
          subtitle: "Empowering Communication ",
          body: "Revolutionize the way you interact with the world ",
          buttonColor: Colors.black,
          titleStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade700,
          ),
          subtitleStyle: TextStyle(
            fontSize: 23,
            color: Colors.grey.shade900,
          ),
          bodyStyle: TextStyle(
            fontSize: 18,
            color: Colors.green.shade400,
          ),
          gradient: const LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network("https://picsum.photos/300/200"))),
      FlutterLiquidSwipeCard(
          onTapName: () => liquidSwipeController?.previous(),
          onSkip: () {},
          name: "Back",
          action: "Done",
          title: "Cutting Edge Technology",
          subtitle: "With an Effortless Experience",
          body:
              "Our innovative speech-to-text solution offers precise transcription",
          buttonColor: Colors.white,
          titleStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          subtitleStyle: TextStyle(
            fontSize: 23,
            color: Colors.grey.shade400,
          ),
          bodyStyle: TextStyle(
            fontSize: 18,
            color: Colors.white.withValues(alpha: .8),
          ),
          gradient: const LinearGradient(
            colors: [Colors.grey, Colors.green],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network("https://picsum.photos/350/200"))),
    ]));
  }
}
