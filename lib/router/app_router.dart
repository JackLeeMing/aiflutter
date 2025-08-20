import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aiflutter/app/entry/app_entry.dart';
import 'package:aiflutter/app/entry/app_entry_demo.dart';
import 'package:aiflutter/widgets/window.dart';

/// 应用路由配置 - 使用 Go Router 实现
/// 提供类型安全、声明式的路由管理
class AppRouter {
  /// 路由配置
  static final GoRouter router = GoRouter(
    // 初始路由
    initialLocation: AppRoutes.home,

    // 错误页面
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),

    // 路由定义
    routes: [
      // 主页路由 - 包装 WindowFrameWidget
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (context, state) => const AppEntryPage(),
      ),

      // 详情页路由 - 支持参数传递
      GoRoute(
        path: AppRoutes.detail,
        name: AppRoutes.detailName,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return DetailPage(
            title: extra?['title'] ?? '详情',
            subtitle: extra?['subtitle'] ?? '',
            icon: extra?['icon'] ?? Icons.info,
            iconColor: extra?['iconColor'] ?? Colors.blue,
          );
        },
      ),

      // 功能模块路由组
      GoRoute(
        path: AppRoutes.features,
        name: AppRoutes.featuresName,
        builder: (context, state) => const FeaturesPage(),
        routes: [
          // 爱心烟花
          GoRoute(
            path: 'fireworks',
            name: AppRoutes.fireworksName,
            builder: (context, state) => const FireworksFeaturePage(),
          ),

          // 几何布局
          GoRoute(
            path: 'geometry',
            name: AppRoutes.geometryName,
            builder: (context, state) => const GeometryFeaturePage(),
          ),

          // 作文灵感
          GoRoute(
            path: 'writing',
            name: AppRoutes.writingName,
            builder: (context, state) => const WritingFeaturePage(),
          ),

          // 口算题
          GoRoute(
            path: 'math',
            name: AppRoutes.mathName,
            builder: (context, state) => const MathFeaturePage(),
          ),
        ],
      ),
    ],

    // 路由重定向
    redirect: (context, state) {
      // 这里可以添加路由守卫逻辑
      // 例如：用户认证检查、权限验证等
      return null; // 返回 null 表示不重定向
    },
  );
}

/// 路由路径常量定义
/// 集中管理所有路由路径，避免硬编码
class AppRoutes {
  // 路由路径
  static const String home = '/';
  static const String detail = '/detail';
  static const String features = '/features';
  static const String fireworks = '/features/fireworks';
  static const String geometry = '/features/geometry';
  static const String writing = '/features/writing';
  static const String math = '/features/math';

  // 路由名称（用于命名导航）
  static const String homeName = 'home';
  static const String detailName = 'detail';
  static const String featuresName = 'features';
  static const String fireworksName = 'fireworks';
  static const String geometryName = 'geometry';
  static const String writingName = 'writing';
  static const String mathName = 'math';
}

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
    go(AppRoutes.detail, extra: {
      'title': title,
      'subtitle': subtitle,
      'icon': icon,
      'iconColor': iconColor,
    });
  }

  /// 跳转到功能页面
  void goToFeature(String featureName) {
    switch (featureName) {
      case '爱心+烟花':
        goNamed(AppRoutes.fireworksName);
        break;
      case 'GeometryReader':
        goNamed(AppRoutes.geometryName);
        break;
      case '作文灵感':
        goNamed(AppRoutes.writingName);
        break;
      case '口算题':
        goNamed(AppRoutes.mathName);
        break;
      default:
        goToDetail(title: featureName, subtitle: '功能开发中...');
    }
  }

  /// 返回上一页
  void goBack() {
    if (canPop()) {
      pop();
    } else {
      go(AppRoutes.home);
    }
  }
}

/// 错误页面
class ErrorPage extends StatelessWidget {
  final String error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('页面错误'),
        backgroundColor: Colors.red[400],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            const Text(
              '页面加载出错',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                error,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.go(AppRoutes.home),
              icon: const Icon(Icons.home),
              label: const Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }
}

/// 功能页面基类
class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('功能模块'),
        ),
        body: const Center(
          child: Text('功能模块页面'),
        ),
      ),
    );
  }
}

/// 具体功能页面示例
class FireworksFeaturePage extends StatelessWidget {
  const FireworksFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('爱心+烟花'),
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back_ios),
          //   onPressed: () => context.goBack(),
          // ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                '爱心烟花效果',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('浪漫动画效果展示'),
            ],
          ),
        ),
      ),
    );
  }
}

class GeometryFeaturePage extends StatelessWidget {
  const GeometryFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GeometryReader'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.goBack(),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.architecture, size: 64, color: Colors.blue),
              SizedBox(height: 16),
              Text(
                'GeometryReader',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('几何布局组件示例'),
            ],
          ),
        ),
      ),
    );
  }
}

class WritingFeaturePage extends StatelessWidget {
  const WritingFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('作文灵感'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.goBack(),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit, size: 64, color: Colors.orange),
              SizedBox(height: 16),
              Text(
                '作文灵感',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('基于主题和字数要求生成相应的好词好句和范文'),
            ],
          ),
        ),
      ),
    );
  }
}

class MathFeaturePage extends StatelessWidget {
  const MathFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('口算题'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.goBack(),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calculate, size: 64, color: Colors.green),
              SizedBox(height: 16),
              Text(
                '口算题',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('生成所选年级的口算题和答案'),
            ],
          ),
        ),
      ),
    );
  }
}
