import 'package:aiflutter/app.dart';
import 'package:aiflutter/nine.dart';
import 'package:aiflutter/setting.dart';
import 'package:aiflutter/tablet.dart';

const flag = 0;
void main() async {
  if (flag == 0) {
    runMain();
  } else if (flag == 1) {
    runSetting(runCupertinoApp: true);
  } else if (flag == 2) {
    runTablet();
  } else {
    runNine();
  }
}
