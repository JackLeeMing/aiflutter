import 'package:flutter/material.dart';

import 'flip_num_text.dart';

class FlipDemo extends StatefulWidget {
  const FlipDemo({super.key});

  @override
  State<FlipDemo> createState() => _FlipDemoState();
}

class _FlipDemoState extends State<FlipDemo> {
  int num = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          FlipNumText(num, 59),
          ElevatedButton(
            child: Text("ADD"),
            onPressed: () {
              setState(() {
                if (num < 60) {
                  num += 1;
                } else {
                  num = 0;
                }
              });
            },
          )
        ],
      ),
    );
  }
}
