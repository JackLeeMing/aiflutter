import 'dart:io';

import 'package:aiflutter/utils/system_util.dart';
import 'package:aiflutter/widgets/flutter_flip_clock.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitClockPage extends StatefulWidget {
  const DigitClockPage({super.key});

  @override
  State<DigitClockPage> createState() => _DigitClockPageState();
}

class _DigitClockPageState extends State<DigitClockPage> {
  @override
  void initState() {
    if (Platform.isIOS || Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    super.initState();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: buildContent(),
    );
  }

  Widget buildClock() {
    return FlipClock(
      startTime: DateTime.now(),
      digitColor: Colors.white,
      backgroundColor: Color.fromRGBO(41, 41, 41, 1.0),
      digitSize: getScreenWidth(context) / 7,
      borderRadius: const BorderRadius.all(Radius.circular(3.0)),
      width: getScreenWidth(context) / 7 - 10,
      height: (getScreenWidth(context) / 7 - 10) * 2,
      screenWidth: getScreenWidth(context),
      screenHeight: getScreenHeight(context),
    );
  }

  Widget buildContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crazy-MT Flip Clock",
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 15, 15, 16),
      ),
      // backgroundColor: Color(0xFFE4E4F5),
      body: Container(
        color: Color.fromARGB(255, 15, 15, 16),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildClock(),
          ],
        ),
      ),
    );
  }
}
