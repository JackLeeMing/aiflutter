// locale_provider.dart
import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  // 初始语言为 null，让 MaterialApp 自动使用系统语言
  Locale _locale = Locale('zh', 'zh');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners(); // 通知所有监听者状态已改变
  }

  void clearLocale() {
    _locale = Locale('en', '');
    notifyListeners();
  }
}
