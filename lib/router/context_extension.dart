import 'package:aiflutter/router/app_routes.dart';
import 'package:aiflutter/widgets/ios_presentation_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 路由扩展方法
/// 提供便捷的导航方法
extension AppRouterExtension on BuildContext {
  /// 跳转到详情页
  void goToDetail({
    required String title,
    String subtitle = '',
    IconData icon = Icons.info,
    Color iconColor = Colors.blue,
  }) {
    push(AppRoutes.detail, extra: {
      'title': title,
      'subtitle': subtitle,
      'icon': icon,
      'iconColor': iconColor,
    });
  }

  /// 跳转到功能页面
  /// 使用 push 导航保持原页面状态
  void goToFeature(String featureName, BuildContext context) {
    switch (featureName) {
      case '爱心+烟花':
        push(AppRoutes.fireworks);
        break;
      case '爱心':
        push(AppRoutes.heart);
        break;
      case '翻页时钟':
        push(AppRoutes.clock);
        break;
      case 'GeometryReader':
        push(AppRoutes.geometry);
        break;
      case 'PreferenceKey':
        goToDetail(title: featureName, subtitle: '偏好设置键值管理');
        break;
      case 'Danymic ToolBar':
        goToDetail(title: featureName, subtitle: '动态工具栏组件');
        break;
      case 'FullScreen Cover':
        // 不使用路由，直接调用展示方法
        _showFullScreenCover(context);
        break;
      case 'Sheet Modal':
        // 不使用路由，直接调用展示方法
        _showSheet(context);
        break;
      case '作文灵感':
        push(AppRoutes.writing);
        break;
      case '口算题':
        push(AppRoutes.math);
        break;
      case '古诗词':
        push(AppRoutes.poetry);
        break;
      case '科学实验':
        push(AppRoutes.science);
        break;
      case '阅读书单':
        push(AppRoutes.reading);
        break;
      case '英语自我介绍':
        push(AppRoutes.english);
        break;
      default:
        goToDetail(title: featureName, subtitle: '功能开发中...');
    }
  }

  /// 返回上一页
  void goBack() {
    // 检查是否可以弹出页面
    if (canPop()) {
      pop();
    } else {
      // 如果不能弹出（比如已经在根页面），则导航到主页
      go(AppRoutes.home);
    }
  }

  /// 安全返回主页
  void goHome() {
    go(AppRoutes.home);
  }
}

/// iOS展示样式的辅助方法
void _showFullScreenCover(BuildContext context) {
  IOSFullScreenCover.show(context);
}

void _showSheet(BuildContext context) {
  IOSSheet.show(context);
}
