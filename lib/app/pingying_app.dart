import 'package:flutter/material.dart';
// import 'package:lpinyin/lpinyin.dart';
import 'package:pinyin/pinyin.dart';
import 'package:ruby_text/ruby_text.dart';
// import '../pages/sales_statistics_page.dart';

class PingYingApp extends StatelessWidget {
  const PingYingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '销售统计',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String text = "天府广场";
    String pinyin = PinyinHelper.getShortPinyin(text);
    String pinyin1 = PinyinHelper.getPinyin(text);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text("Pinyin", style: TextStyle(color: Colors.white)),
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
              child: Image.asset("assets/flutter.png"),
            ),
          ],
        ),
      ),
    );
  }
}
