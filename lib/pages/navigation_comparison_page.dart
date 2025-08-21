import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Go Router 导航方式对比演示
/// 展示 push 与 go/goNamed 的区别
class NavigationComparisonPage extends StatefulWidget {
  const NavigationComparisonPage({super.key});

  @override
  State<NavigationComparisonPage> createState() => _NavigationComparisonDemoState();
}

class _NavigationComparisonDemoState extends State<NavigationComparisonPage> {
  int _counter = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航方式对比'),
        backgroundColor: Colors.purple[100],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 状态指示器
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                children: [
                  const Text(
                    '📊 当前页面状态',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStateItem('计数器', '$_counter'),
                      _buildStateItem(
                          '滚动位置', '${_scrollController.hasClients ? _scrollController.offset.toInt() : 0}px'),
                      _buildStateItem('页面ID', '${hashCode.toString().substring(0, 6)}'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 计数器控制
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      '🎯 修改状态测试',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => setState(() => _counter++),
                          child: const Text('计数器 +1'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_scrollController.hasClients) {
                              _scrollController.animateTo(
                                200,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: const Text('滚动到200px'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 导航方式对比
            const Text(
              '🚀 导航方式对比',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Push 导航
            _buildNavigationCard(
              title: '✅ context.push() - 推荐',
              subtitle: '保持页面状态，适合详情页查看',
              color: Colors.green,
              onPressed: () {
                context.push('/test-detail?method=push');
              },
              features: [
                '✅ 原页面状态保持',
                '✅ 返回时数据不变',
                '✅ 滚动位置保持',
                '✅ 内存中保留页面',
                '🎯 适合：详情查看、临时页面',
              ],
            ),

            const SizedBox(height: 16),

            // Go 导航
            _buildNavigationCard(
              title: '⚠️ context.go() / goNamed()',
              subtitle: '替换页面栈，会销毁原页面',
              color: Colors.orange,
              onPressed: () {
                context.go('/test-detail?method=go');
              },
              features: [
                '❌ 原页面被销毁',
                '❌ 返回时重新构建',
                '❌ 状态丢失',
                '❌ 滚动位置重置',
                '🎯 适合：主要导航、完全切换',
              ],
            ),

            const SizedBox(height: 24),

            // 性能对比
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '⚡ 性能对比',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildPerformanceItem('内存使用', 'push: 较高（保持状态）', 'go: 较低（释放内存）'),
                  _buildPerformanceItem('返回速度', 'push: 快速（无需重建）', 'go: 慢（需要重建）'),
                  _buildPerformanceItem('用户体验', 'push: 流畅连续', 'go: 可能有闪烁'),
                  _buildPerformanceItem('使用建议', 'push: 短期导航', 'go: 长期导航'),
                ],
              ),
            ),

            // 填充空间用于滚动测试
            ...List.generate(
                20,
                (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '滚动测试项目 ${index + 1} - 修改状态后，使用不同导航方式查看区别',
                        style: const TextStyle(fontSize: 14),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  Widget _buildStateItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationCard({
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onPressed,
    required List<String> features,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    feature,
                    style: const TextStyle(fontSize: 13),
                  ),
                )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                ),
                child: const Text('测试此导航方式'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceItem(String title, String push, String go) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 2),
          Text('• $push', style: const TextStyle(fontSize: 12, color: Colors.green)),
          Text('• $go', style: const TextStyle(fontSize: 12, color: Colors.orange)),
        ],
      ),
    );
  }
}

/// 测试详情页
class TestDetailPage extends StatelessWidget {
  final String method;

  const TestDetailPage({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试页面 ($method)'),
        backgroundColor: method == 'push' ? Colors.green[100] : Colors.orange[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              method == 'push' ? Icons.layers : Icons.swap_horiz,
              size: 80,
              color: method == 'push' ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 24),
            Text(
              '导航方式: ${method.toUpperCase()}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                method == 'push' ? '返回时原页面状态将被保持\n计数器和滚动位置不变' : '返回时原页面将被重建\n计数器和滚动位置重置',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('返回查看差异'),
              style: ElevatedButton.styleFrom(
                backgroundColor: method == 'push' ? Colors.green : Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
