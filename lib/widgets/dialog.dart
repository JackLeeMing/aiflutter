import 'package:aiflutter/utils/loggerUtil.dart';
import 'package:aiflutter/widgets/haptic_feedback.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

Future<dynamic> showBeautyDialog(
  BuildContext context, {
  required QuickAlertType type,
  String? text,
  String? title,
  String? customAsset,
  Widget? widget,
  String confirmBtnText = '确定',
  String? cancelBtnText,
  Function()? onConfirmBtnTap,
  Function()? onCancelBtnTap,
  bool showCancelBtn = false,
  bool barrierDismissible = false, // 禁止点击外部关闭
}) {
  return QuickAlert.show(
    context: context,
    type: type,
    text: text,
    customAsset: customAsset,
    widget: widget,
    width: MediaQuery.of(context).size.width > 600 ? 400 : null,
    barrierDismissible: barrierDismissible,
    showCancelBtn: showCancelBtn,
    confirmBtnText: confirmBtnText,
    cancelBtnText: cancelBtnText ?? "取消",
    confirmBtnColor: Color.fromARGB(255, 9, 185, 85),
    borderRadius: 10,
    // buttonBorderRadius: 10,
    backgroundColor: Colors.white,
    confirmBtnTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
    ),
    title: title ?? '',
    titleColor: Color.fromARGB(195, 0, 0, 0),
    textColor: Color.fromARGB(195, 0, 0, 0),
    cancelBtnTextStyle: TextStyle(
      color: Color.fromARGB(195, 0, 0, 0),
      fontWeight: FontWeight.normal,
    ),
    onConfirmBtnTap: onConfirmBtnTap,
    onCancelBtnTap: onCancelBtnTap,
  );
}

showErrorMessage(String message, {Duration duration = const Duration(seconds: 3)}) {
  HapticFeedbackHelper.mediumImpact();
  logger.e(message);

  BotToast.showText(
    text: message,
    duration: duration,
    textStyle: const TextStyle(
      fontSize: 15,
      color: Colors.white,
    ),
    align: Alignment.center,
  );
}

showSuccessMessage(String message, {Duration duration = const Duration(seconds: 3)}) async {
  BotToast.showText(
    text: message,
    duration: duration,
    textStyle: const TextStyle(
      fontSize: 15,
      color: Colors.white,
    ),
    align: Alignment.center,
    contentColor: Colors.black,
  );
}

showTDErrorMessage(
  BuildContext context,
  String message,
) {
  HapticFeedbackHelper.mediumImpact();
  logger.e(message);
  TDMessage.showMessage(
    context: context,
    content: message,
    visible: true,
    icon: true,
    theme: MessageTheme.error,
    duration: 3000,
  );
}

showTDSuccessMessage(
  BuildContext context,
  String message,
) {
  TDMessage.showMessage(
    context: context,
    content: message,
    visible: true,
    icon: true,
    theme: MessageTheme.success,
    duration: 3000,
  );
}

showTDWarningMessage(
  BuildContext context,
  String message,
) {
  HapticFeedbackHelper.mediumImpact();
  logger.w(message);
  TDMessage.showMessage(
    context: context,
    content: message,
    visible: true,
    icon: true,
    theme: MessageTheme.warning,
    duration: 3000,
  );
}
