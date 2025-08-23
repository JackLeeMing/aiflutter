import 'package:aiflutter/app.dart';
import 'package:aiflutter/nine.dart';
import 'package:aiflutter/setting.dart';

const flag = 1;
void main() async {
  if (flag == 0) {
    runMain();
  } else if (flag == 1) {
    runSetting();
  } else {
    runNine();
  }
}
