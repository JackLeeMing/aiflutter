import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart';

/// 路由测试页面
/// 用于测试和验证路由配置是否正确工作
class RouterTestPage extends StatelessWidget {
  const RouterTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('路由测试'),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '🚀 路由测试页面',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildTestButton(
              context,
              title: '跳转到首页',
              subtitle: '测试主页路由',
              onPressed: () => context.go(AppRoutes.home),
              icon: Icons.home,
              color: Colors.blue,
            ),
            _buildTestButton(
              context,
              title: '跳转到详情页',
              subtitle: '测试详情页路由',
              onPressed: () => context.goToDetail(
                title: '测试详情',
                subtitle: '这是一个测试详情页面',
                icon: Icons.info,
                iconColor: Colors.orange,
              ),
              icon: Icons.info,
              color: Colors.orange,
            ),
            _buildTestButton(
              context,
              title: '爱心烟花功能',
              subtitle: '测试功能页面路由',
              onPressed: () => context.goToFeature('爱心+烟花', context),
              icon: Icons.favorite,
              color: Colors.red,
            ),
            _buildTestButton(
              context,
              title: '几何布局功能',
              subtitle: '测试几何布局页面',
              onPressed: () => context.goToFeature('GeometryReader', context),
              icon: Icons.architecture,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📋 路由信息',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('当前路由: ${GoRouterState.of(context).uri.toString()}'),
                  Text('路由名称: ${GoRouterState.of(context).name ?? "未设置"}'),
                  const SizedBox(height: 8),
                  const Text(
                    '✅ 如果您能看到这个页面，说明路由配置工作正常！',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.1),
          foregroundColor: color,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: color.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
      ),
    );
  }
}

/// 路由测试应用
class RouterTestApp extends StatelessWidget {
  const RouterTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '路由测试应用',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
