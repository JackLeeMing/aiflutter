import 'package:flutter/material.dart';

/// 滚动位置管理器
/// 用于保存和恢复列表的滚动位置，提升用户体验
class ScrollPositionManager {
  static final ScrollPositionManager _instance = ScrollPositionManager._internal();
  factory ScrollPositionManager() => _instance;
  ScrollPositionManager._internal();

  // 存储不同页面的滚动位置
  final Map<String, double> _scrollPositions = {};

  /// 保存滚动位置
  void saveScrollPosition(String key, double position) {
    _scrollPositions[key] = position;
    debugPrint('💾 保存滚动位置: $key -> $position');
  }

  /// 获取滚动位置
  double? getScrollPosition(String key) {
    final position = _scrollPositions[key];
    debugPrint('📖 读取滚动位置: $key -> $position');
    return position;
  }

  /// 清除指定页面的滚动位置
  void clearScrollPosition(String key) {
    _scrollPositions.remove(key);
    debugPrint('🗑️ 清除滚动位置: $key');
  }

  /// 清除所有滚动位置
  void clearAllPositions() {
    _scrollPositions.clear();
    debugPrint('🗑️ 清除所有滚动位置');
  }

  /// 获取所有保存的位置信息
  Map<String, double> getAllPositions() {
    return Map.unmodifiable(_scrollPositions);
  }
}

/// 智能滚动恢复 Mixin
/// 为页面提供自动的滚动位置保存和恢复功能
mixin SmartScrollRestoration<T extends StatefulWidget> on State<T> {
  ScrollController? _smartScrollController;
  late final String _pageKey;
  final ScrollPositionManager _positionManager = ScrollPositionManager();

  /// 页面的唯一标识符，子类需要重写
  String get pageKey;

  /// 获取滚动控制器
  ScrollController get scrollController {
    _smartScrollController ??= ScrollController();
    return _smartScrollController!;
  }

  @override
  void initState() {
    super.initState();
    _pageKey = pageKey;

    // 确保scrollController被初始化
    final controller = scrollController;

    // 在下一帧恢复滚动位置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _restoreScrollPosition();
    });

    // 监听滚动变化并保存位置
    controller.addListener(_onScrollChanged);
  }

  @override
  void dispose() {
    _saveCurrentPosition();
    if (_smartScrollController != null) {
      _smartScrollController!.removeListener(_onScrollChanged);
      _smartScrollController!.dispose();
    }
    super.dispose();
  }

  /// 监听滚动变化
  void _onScrollChanged() {
    if (_smartScrollController?.hasClients == true) {
      _positionManager.saveScrollPosition(_pageKey, _smartScrollController!.offset);
    }
  }

  /// 恢复滚动位置
  void _restoreScrollPosition() {
    final position = _positionManager.getScrollPosition(_pageKey);
    if (position != null && _smartScrollController?.hasClients == true) {
      try {
        _smartScrollController!.animateTo(
          position,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } catch (e) {
        debugPrint('⚠️ 恢复滚动位置失败: $e');
        // 如果动画失败，尝试直接跳转
        try {
          _smartScrollController!.jumpTo(position);
        } catch (e) {
          debugPrint('⚠️ 直接跳转滚动位置也失败: $e');
        }
      }
    }
  }

  /// 保存当前滚动位置
  void _saveCurrentPosition() {
    if (_smartScrollController?.hasClients == true) {
      _positionManager.saveScrollPosition(_pageKey, _smartScrollController!.offset);
    }
  }

  /// 手动恢复到指定位置
  void restoreToPosition(double position, {bool animate = true}) {
    if (_smartScrollController?.hasClients == true) {
      if (animate) {
        _smartScrollController!.animateTo(
          position,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _smartScrollController!.jumpTo(position);
      }
    }
  }

  /// 滚动到顶部
  void scrollToTop({bool animate = true}) {
    restoreToPosition(0, animate: animate);
  }

  /// 滚动到底部
  void scrollToBottom({bool animate = true}) {
    if (_smartScrollController?.hasClients == true) {
      final maxScrollExtent = _smartScrollController!.position.maxScrollExtent;
      restoreToPosition(maxScrollExtent, animate: animate);
    }
  }
}

/// 页面滚动状态指示器
class ScrollPositionIndicator extends StatefulWidget {
  final ScrollController controller;
  final Color? color;
  final double width;
  final double height;

  const ScrollPositionIndicator({
    super.key,
    required this.controller,
    this.color,
    this.width = 4.0,
    this.height = 60.0,
  });

  @override
  State<ScrollPositionIndicator> createState() => _ScrollPositionIndicatorState();
}

class _ScrollPositionIndicatorState extends State<ScrollPositionIndicator> {
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateScrollProgress);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateScrollProgress);
    super.dispose();
  }

  void _updateScrollProgress() {
    if (widget.controller.hasClients) {
      final position = widget.controller.position;
      final progress = position.pixels / (position.maxScrollExtent > 0 ? position.maxScrollExtent : 1);
      setState(() {
        _scrollProgress = progress.clamp(0.0, 1.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(widget.width / 2),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: widget.height * _scrollProgress,
            child: Container(
              decoration: BoxDecoration(
                color: widget.color ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(widget.width / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
