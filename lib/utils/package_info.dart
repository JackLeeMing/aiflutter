import 'package:aiflutter/utils/loggerUtil.dart';
import 'package:package_info_plus/package_info_plus.dart';

late PackageInfo packageInfo;

Future<void> initPackageInfo() async {
  try {
    packageInfo = await PackageInfo.fromPlatform();
  } catch (e) {
    logger.e("init package info fail", error: e);
  }
}
