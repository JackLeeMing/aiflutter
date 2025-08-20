import 'package:flutter/material.dart';

/// 简化版滚动位置管理器
/// 更稳定、更简单的滚动位置保持方案
class SimpleScrollManager {
  static final SimpleScrollManager _instance = SimpleScrollManager._internal();
  factory SimpleScrollManager() => _instance;
  SimpleScrollManager._internal();

  final Map<String, double> _positions = {};

  void savePosition(String key, double position) {
    _positions[key] = position;
  }

  double getPosition(String key) {
    return _positions[key] ?? 0.0;
  }

  void clearPosition(String key) {
    _positions.remove(key);
  }
}

/// 简化版智能滚动Widget
/// 自动处理滚动位置的保存和恢复
class SmartScrollView extends StatefulWidget {
  final String pageKey;
  final Widget Function(ScrollController controller) builder;
  final EdgeInsetsGeometry? padding;
  final bool reverse;
  final ScrollPhysics? physics;

  const SmartScrollView({
    super.key,
    required this.pageKey,
    required this.builder,
    this.padding,
    this.reverse = false,
    this.physics,
  });

  @override
  State<SmartScrollView> createState() => _SmartScrollViewState();
}

class _SmartScrollViewState extends State<SmartScrollView> {
  late final ScrollController _controller;
  final SimpleScrollManager _manager = SimpleScrollManager();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    // 恢复滚动位置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final position = _manager.getPosition(widget.pageKey);
      if (position > 0 && _controller.hasClients) {
        _controller.animateTo(
          position,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    // 监听滚动变化
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _savePosition();
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.hasClients) {
      _manager.savePosition(widget.pageKey, _controller.offset);
    }
  }

  void _savePosition() {
    if (_controller.hasClients) {
      _manager.savePosition(widget.pageKey, _controller.offset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_controller);
  }
}
