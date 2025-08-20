import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aiflutter/router/app_router.dart';

/// 使用 Go Router 的演示应用
/// 展示现代化路由管理的最佳实践
class RouterAppDemo extends StatelessWidget {
  const RouterAppDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AI Flutter - 现代路由管理',
      debugShowCheckedModeBanner: false,

      // 使用 Go Router
      routerConfig: AppRouter.router,

      // Material Design 3 主题
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,

        // 现代化的 AppBar 样式
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 1,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),

        // 卡片样式
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // 按钮样式
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
        ),
      ),

      // 深色主题
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      // 主题模式
      themeMode: ThemeMode.system,
    );
  }
}

/// 路由管理最佳实践示例
class RouterBestPracticesDemo extends StatefulWidget {
  const RouterBestPracticesDemo({super.key});

  @override
  State<RouterBestPracticesDemo> createState() => _RouterBestPracticesDemoState();
}

class _RouterBestPracticesDemoState extends State<RouterBestPracticesDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('路由管理最佳实践'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('🚀 Go Router 优势'),
            _buildFeatureCard([
              '✅ 声明式路由配置，易于维护',
              '✅ 完美支持 Web URL 和深度链接',
              '✅ 内置路由守卫和重定向',
              '✅ 类型安全的参数传递',
              '✅ 官方维护，兼容性最佳',
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('📋 路由管理建议'),
            _buildFeatureCard([
              '🔹 集中管理路由路径常量',
              '🔹 使用扩展方法简化导航',
              '🔹 实现统一的错误处理',
              '🔹 合理使用嵌套路由',
              '🔹 添加路由守卫保护敏感页面',
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('🛠️ 代码示例'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const SingleChildScrollView(
                  child: Text(
                    '''// 1. 路径常量管理
class AppRoutes {
  static const String home = '/';
  static const String detail = '/detail';
}

// 2. 扩展方法导航
extension AppRouterExtension on BuildContext {
  void goToDetail({required String title}) {
    go(AppRoutes.detail, extra: {'title': title});
  }
}

// 3. 使用示例
context.goToDetail(title: '详情页');''',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFeatureCard(List<String> features) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: features
              .map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      feature,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
