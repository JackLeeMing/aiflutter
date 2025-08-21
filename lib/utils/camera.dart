import 'package:aiflutter/utils/loggerUtil.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// 检查并请求相机权限的函数
Future<void> checkCameraPermission(BuildContext context,
    {required VoidCallback okBack, required VoidCallback failBack}) async {
  // 1. 检查当前相机权限状态
  var status = await Permission.camera.status;

  // 2. 如果权限已被授予，直接跳转到相机页面
  if (status.isGranted) {
    logger.d("相机权限已被授予，正在进入相机页面...");
    // 假设这是你的相机页面
    okBack();
  }
  // 3. 如果权限已被拒绝，但用户没有永久拒绝，则请求权限
  else if (status.isDenied) {
    logger.d("相机权限未授予，正在请求权限...");
    // 发起权限请求
    var newStatus = await Permission.camera.request();

    // 检查新的权限状态
    if (newStatus.isGranted) {
      logger.d("权限请求成功，正在进入相机页面...");
      okBack();
    } else {
      logger.d("权限请求被拒绝，无法进入相机页面。");
      failBack();
    }
  }
  // 4. 如果权限被永久拒绝，引导用户到应用设置
  else if (status.isPermanentlyDenied) {
    logger.d("相机权限被永久拒绝，正在引导用户到设置页面...");
    // 弹出对话框，提示用户去设置中手动开启
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('需要相机权限'),
        content: const Text('请在设置中开启相机权限，以便使用此功能。'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings(); // 打开应用设置页面
            },
            child: const Text('前往设置'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }
}
