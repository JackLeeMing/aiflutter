import 'package:aiflutter/widgets/flip_panel.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';

class FlutterFlipAnimationPage extends StatelessWidget {
  final digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  FlutterFlipAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flip Widget",
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
            buildFlip(),
          ],
        ),
      ),
    );
  }

  Widget buildFlip() {
    return FlipPanel.builder(
      direction: FlipDirection.up,
      itemBuilder: (context, index) => Container(
        alignment: Alignment.center,
        width: 102.0,
        height: 128.0,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(41, 41, 41, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Text(
          '${digits[digits.length - index - 1]}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 60.0,
            color: Colors.red,
          ),
        ),
      ),
      itemsCount: digits.length,
      period: const Duration(milliseconds: 1000),
      loop: -1,
    );
  }
}
