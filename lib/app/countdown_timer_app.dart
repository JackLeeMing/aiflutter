import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class CountdownTimerApp extends StatelessWidget {
  const CountdownTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Countdown Timer Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Circular Countdown Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _duration = 10;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: CircularCountDownTimer(
          // Countdown duration in Seconds.
          duration: _duration,

          // Countdown initial elapsed Duration in Seconds.
          initialDuration: 0,

          // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
          controller: _controller,

          // Width of the Countdown Widget.
          width: MediaQuery.of(context).size.width / 2,

          // Height of the Countdown Widget.
          height: MediaQuery.of(context).size.height / 2,

          // Ring Color for Countdown Widget.
          ringColor: Colors.grey[300]!,

          // Ring Gradient for Countdown Widget.
          ringGradient: null,

          // Filling Color for Countdown Widget.
          fillColor: Colors.purpleAccent[100]!,

          // Filling Gradient for Countdown Widget.
          fillGradient: null,

          // Background Color for Countdown Widget.
          backgroundColor: Colors.purple[500],

          // Background Gradient for Countdown Widget.
          backgroundGradient: null,

          // Border Thickness of the Countdown Ring.
          strokeWidth: 20.0,

          // Begin and end contours with a flat edge and no extension.
          strokeCap: StrokeCap.round,

          // Text Style for Countdown Text.
          textStyle: const TextStyle(
            fontSize: 33.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          // Format for the Countdown Text.
          textFormat: CountdownTextFormat.S,

          // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
          isReverse: false,

          // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
          isReverseAnimation: false,

          // Handles visibility of the Countdown Text.
          isTimerTextShown: true,

          // Handles the timer start.
          autoStart: true,

          // This Callback will execute when the Countdown Starts.
          onStart: () {
            // Here, do whatever you want
            debugPrint('Countdown Started');
          },

          // This Callback will execute when the Countdown Ends.
          onComplete: () {
            // Here, do whatever you want
            debugPrint('Countdown Ended');
          },

          // timeFormatterFunction: (defaultFormatterFunction, duration) {
          //   if (duration.inSeconds == 0) {
          //     //only format for '0'
          //     return "Start";
          //   } else {
          //     //others durations by it's default format
          //     return Function.apply(defaultFormatterFunction, [duration]);
          //   }
          // },

          // This Callback will execute when the Countdown Changes.
          onChange: (String timeStamp) {
            // Here, do whatever you want
            debugPrint('Countdown Changed $timeStamp');
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          _button(
            title: "Start",
            onPressed: () => _controller.start(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Pause",
            onPressed: () {
              _controller.pause();
              debugPrint("Pause ${_controller.isPaused}");
              debugPrint("Resume ${_controller.isResumed}");
            },
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Resume",
            onPressed: () {
              _controller.resume();
              debugPrint("Pause ${_controller.isPaused}");
              debugPrint("Resume ${_controller.isResumed}");
            },
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Restart",
            onPressed: () => _controller.restart(duration: _duration),
          ),
        ],
      ),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.purple),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
