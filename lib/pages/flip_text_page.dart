import 'package:aiflutter/widgets/flip_num_text.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';

class FlipTextPage extends StatefulWidget {
  const FlipTextPage({super.key});

  @override
  State<FlipTextPage> createState() => _FlipDemoState();
}

class _FlipDemoState extends State<FlipTextPage> {
  int num = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flip Text",
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 15, 15, 16),
      ),
      body: Container(
        color: Color.fromARGB(255, 15, 15, 16),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlipNumText(num, 10),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("+"),
                  onPressed: () {
                    setState(() {
                      if (num < 10) {
                        num += 1;
                      } else {
                        num = 0;
                      }
                    });
                  },
                ),
                SizedBox(width: 50),
                ElevatedButton(
                  child: const Text("-"),
                  onPressed: () {
                    setState(() {
                      if (num > 0) {
                        num -= 1;
                      } else {
                        num = 9;
                      }
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
