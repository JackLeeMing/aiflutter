import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
// import 'package:lpinyin/lpinyin.dart';
import 'package:pinyin/pinyin.dart';
import 'package:ruby_text/ruby_text.dart';

class PingYingPage extends StatefulWidget {
  const PingYingPage({super.key});

  @override
  State<PingYingPage> createState() => _HomePageState();
}

class _HomePageState extends State<PingYingPage> {
  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    String text = "天府广场";
    String pinyin = PinyinHelper.getShortPinyin(text);
    String pinyin1 = PinyinHelper.getPinyin(text);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          "Pinyin",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: RubyText(
                [
                  RubyTextData(
                    text,
                    ruby: pinyin,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: RubyText(
                [
                  RubyTextData(
                    text,
                    ruby: pinyin1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Image.asset(
                "assets/flutter.png",
                width: 150,
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
