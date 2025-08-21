import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:ruby_text/ruby_text.dart';

class RudyTextPage extends StatelessWidget {
  const RudyTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RudyText"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(64),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: RubyText(
                    [
                      RubyTextData(
                        '中国',
                        ruby: 'zhōng guó',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: RubyText(
                    [
                      RubyTextData(
                        '检查',
                        ruby: 'jian cha',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: RubyText(
                    [
                      RubyTextData(
                        '检查检查',
                        ruby: 'jian cha jian cha',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
