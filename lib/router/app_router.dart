import 'package:aiflutter/pages/clock/flutter_flip_clock_page.dart';
import 'package:aiflutter/pages/firework_page.dart';
import 'package:aiflutter/utils/constant.dart';
import 'package:aiflutter/utils/transition_resolver.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aiflutter/app/entry/app_entry.dart';
import 'package:aiflutter/app/entry/app_entry_demo.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:aiflutter/widgets/ios_presentation_styles.dart';

/// 应用路由配置 - 使用 Go Router 实现
/// 提供类型安全、声明式的路由管理
class AppRouter {
  /// 路由配置
  static final GoRouter router = GoRouter(
    // 初始路由
    initialLocation: AppRoutes.home,
    navigatorKey: AppConstant.navigatorKey,
    observers: [],

    // 错误页面
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),

    // 路由定义
    routes: [
      // 主页路由 - 包装 WindowFrameWidget
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        pageBuilder: (context, state) => transitionResolver(const AppEntryPage()),
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

      // 爱心烟花功能页
      GoRoute(
        path: AppRoutes.heart,
        name: AppRoutes.heartName,
        pageBuilder: (context, state) => transitionResolver(const FireworksFeaturePage()),
      ),

      // 几何布局功能页
      GoRoute(
        path: AppRoutes.geometry,
        name: AppRoutes.geometryName,
        pageBuilder: (context, state) => transitionResolver(const GeometryFeaturePage()),
      ),

      // 作文灵感功能页
      GoRoute(
        path: AppRoutes.writing,
        name: AppRoutes.writingName,
        pageBuilder: (context, state) => transitionResolver(const WritingFeaturePage()),
      ),

      // 口算题功能页
      GoRoute(
        path: AppRoutes.math,
        name: AppRoutes.mathName,
        pageBuilder: (context, state) => transitionResolver(const MathFeaturePage()),
      ),

      // 古诗词功能页
      GoRoute(
        path: AppRoutes.poetry,
        name: AppRoutes.poetryName,
        pageBuilder: (context, state) => transitionResolver(const PoetryFeaturePage()),
      ),

      // 科学实验功能页
      GoRoute(
        path: AppRoutes.science,
        name: AppRoutes.scienceName,
        pageBuilder: (context, state) => transitionResolver(const ScienceFeaturePage()),
      ),

      // 阅读书单功能页
      GoRoute(
        path: AppRoutes.reading,
        name: AppRoutes.readingName,
        pageBuilder: (context, state) => transitionResolver(const ReadingFeaturePage()),
      ),

      // 英语自我介绍功能页
      GoRoute(
        path: AppRoutes.english,
        name: AppRoutes.englishName,
        pageBuilder: (context, state) => transitionResolver(const EnglishFeaturePage()),
      ),

      GoRoute(
        path: AppRoutes.fireworks,
        name: AppRoutes.fireworksName,
        pageBuilder: (context, state) => transitionResolver(const FireworksPage()),
      ),
      GoRoute(
        path: AppRoutes.clock,
        name: AppRoutes.clockName,
        pageBuilder: (context, state) => transitionResolver(const FlutterFlipClockPage()),
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
  static const String fireworks = '/fireworks';
  static const String heart = '/heart';
  static const String geometry = '/geometry';
  static const String writing = '/writing';
  static const String math = '/math';
  static const String poetry = '/poetry';
  static const String science = '/science';
  static const String reading = '/reading';
  static const String english = '/english';
  static const String clock = '/clock';
  // 路由名称（用于命名导航）
  static const String homeName = 'home';
  static const String detailName = 'detail';
  static const String fireworksName = 'fireworks';
  static const String heartName = 'heart';
  static const String geometryName = 'geometry';
  static const String writingName = 'writing';
  static const String mathName = 'math';
  static const String poetryName = 'poetry';
  static const String scienceName = 'science';
  static const String readingName = 'reading';
  static const String englishName = 'english';
  static const String clockName = 'clock';
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

/// 具体功能页面示例
class FireworksFeaturePage extends StatelessWidget {
  const FireworksFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('爱心+烟花'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.goBack(),
          ),
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

/// 古诗词功能页
class PoetryFeaturePage extends StatelessWidget {
  const PoetryFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('古诗词'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.goBack(),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_stories, size: 64, color: Colors.brown),
              SizedBox(height: 16),
              Text(
                '古诗词',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('根据需求生产古诗词背诵单'),
            ],
          ),
        ),
      ),
    );
  }
}

/// 科学实验功能页
class ScienceFeaturePage extends StatelessWidget {
  const ScienceFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('科学实验'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.goBack(),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.science, size: 64, color: Colors.teal),
              SizedBox(height: 16),
              Text(
                '科学实验',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('根据主题生成三个适合所选年龄段的科学实验步骤'),
            ],
          ),
        ),
      ),
    );
  }
}

/// 阅读书单功能页
class ReadingFeaturePage extends StatelessWidget {
  const ReadingFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('阅读书单'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.goBack(),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.library_books, size: 64, color: Colors.indigo),
              SizedBox(height: 16),
              Text(
                '阅读书单',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('根据需求生成对应的阅读书单'),
            ],
          ),
        ),
      ),
    );
  }
}

/// 英语自我介绍功能页
class EnglishFeaturePage extends StatelessWidget {
  const EnglishFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('英语自我介绍'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.goBack(),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.translate, size: 64, color: Colors.blue),
              SizedBox(height: 16),
              Text(
                '英语自我介绍',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('根据需求生成英文版和中文版的自我介绍'),
            ],
          ),
        ),
      ),
    );
  }
}
