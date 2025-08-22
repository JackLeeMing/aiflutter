// library flip_panel;
import 'dart:async';

import 'package:aiflutter/widgets/flip_panel.dart';
import 'package:flutter/material.dart';

typedef Widget DigitBuilder(BuildContext, int);

class FlipClock extends StatelessWidget {
  DigitBuilder? _digitBuilder;
  Widget? _separator;
  final DateTime startTime;
  final EdgeInsets spacing;
  final FlipDirection flipDirection;

  /// Set countdown to true to have a countdown timer.
  final bool countdownMode;

  final bool _showHours;
  final bool _showDays;

  Duration? timeLeft;

  /// Called when the countdown clock hits zero.
  final VoidCallback? onDone;

  final double height;
  final double width;

  final double screenWidth;
  final double screenHeight;

  FlipClock({
    super.key,
    required this.startTime,
    required Color digitColor,
    required Color backgroundColor,
    required double digitSize,
    required this.width,
    required this.height,
    required this.screenWidth,
    required this.screenHeight,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(0.0)),
    this.spacing = const EdgeInsets.symmetric(horizontal: 2.0),
    this.flipDirection = FlipDirection.down,
    this.onDone,
  })  : countdownMode = false,
        _showHours = true,
        _showDays = false {
    _digitBuilder = (context, digit) => Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
          ),
          child: Text(
            '$digit',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: digitSize,
              color: digitColor,
              decoration: TextDecoration.none,
            ),
          ),
        );
    _separator = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      width: width / 2,
      height: height,
      alignment: Alignment.center,
      child: Text(
        ':',
        style: TextStyle(
          fontSize: digitSize,
          color: digitColor,
          decoration: TextDecoration.none,
        ),
      ),
    );
    // debugPrint("MTMTMTMT$screenWidth---$screenHeight--$width--$height--$digitSize");
  }

  @override
  Widget build(BuildContext context) {
    var time = startTime;
    final initStream = Stream<DateTime>.periodic(Duration(milliseconds: 1000), (_) {
      var oldTime = time;
      (countdownMode) ? timeLeft = timeLeft! - Duration(seconds: 1) : time = time.add(Duration(seconds: 1));

      if (!countdownMode && oldTime.day != time.day) {
        time = oldTime;
        if (onDone != null) onDone!();
      }

      return time;
    });
    final timeStream = (countdownMode ? initStream.take(timeLeft!.inSeconds) : initStream).asBroadcastStream();

    var digitList = <Widget>[];
    // TODO(efortuna): Instead, allow the user to specify the format of time instead.
    // Add hours if appropriate.

    if (_showDays) {
      digitList.addAll([
        _buildSegment(timeStream, (DateTime time) => (timeLeft!.inDays > 99) ? 9 : (timeLeft!.inDays ~/ 10),
            (DateTime time) => (timeLeft!.inDays > 99) ? 9 : (timeLeft!.inDays % 10), startTime, "days"),
        Column(
          children: [
            Padding(
              padding: spacing,
              child: _separator,
            ),
            (_showDays) ? Container(color: Colors.black) : Container(color: Colors.transparent)
          ],
        )
      ]);
    }

    if (_showHours) {
      digitList.addAll([
        _buildSegment(
            timeStream,
            (DateTime time) => (countdownMode) ? (timeLeft!.inHours % 24) ~/ 10 : (time.hour) ~/ 10,
            (DateTime time) => (countdownMode) ? (timeLeft!.inHours % 24) % 10 : (time.hour) % 10,
            startTime,
            "Hours"),
        Column(
          children: <Widget>[
            Padding(
              padding: spacing,
              child: _separator,
            ),
            (_showDays)
                ? Container(color: Colors.black)
                : Container(
                    color: Colors.transparent,
                  )
          ],
        )
      ]);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: digitList
        ..addAll([
          // Minutes
          _buildSegment(
              timeStream,
              (DateTime time) => (countdownMode) ? (timeLeft!.inMinutes % 60) ~/ 10 : (time.minute) ~/ 10,
              (DateTime time) => (countdownMode) ? (timeLeft!.inMinutes % 60) % 10 : (time.minute) % 10,
              startTime,
              "minutes"),

          Column(
            children: <Widget>[
              Padding(
                padding: spacing,
                child: _separator,
              ),
              (_showDays)
                  ? Container(color: Colors.black)
                  : Container(
                      color: Colors.transparent,
                    )
            ],
          ),

          // Seconds
          _buildSegment(
              timeStream,
              (DateTime time) => (countdownMode) ? (timeLeft!.inSeconds % 60) ~/ 10 : (time.second) ~/ 10,
              (DateTime time) => (countdownMode) ? (timeLeft!.inSeconds % 60) % 10 : (time.second) % 10,
              startTime,
              "seconds")
        ]),
    );
  }

  _buildSegment(Stream<DateTime> timeStream, int Function(DateTime) tensDigit, int Function(DateTime) onesDigit,
      DateTime startTime, String id) {
    return Column(
      children: <Widget>[
        Row(children: [
          Padding(
            padding: spacing,
            child: FlipPanel<int>.stream(
              itemStream: timeStream.map<int>(tensDigit),
              itemBuilder: _digitBuilder!,
              duration: const Duration(milliseconds: 450),
              initValue: tensDigit(startTime),
              direction: flipDirection,
            ),
          ),
          Padding(
            padding: spacing,
            child: FlipPanel<int>.stream(
              itemStream: timeStream.map<int>(onesDigit),
              itemBuilder: _digitBuilder!,
              duration: const Duration(milliseconds: 450),
              initValue: onesDigit(startTime),
              direction: flipDirection,
            ),
          ),
        ]),
        (_showDays)
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            id.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Row()
      ],
    );
  }
}
