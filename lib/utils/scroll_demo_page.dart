import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'scroll_position_manager.dart';

/// 滚动位置保持功能演示页面
class ScrollDemoPage extends StatefulWidget {
  const ScrollDemoPage({super.key});

  @override
  State<ScrollDemoPage> createState() => _ScrollDemoPageState();
}

class _ScrollDemoPageState extends State<ScrollDemoPage> with SmartScrollRestoration {
  @override
  String get pageKey => 'scroll_demo_page';

  final List<String> demoItems = List.generate(50, (index) => '演示项目 ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滚动位置保持演示'),
        backgroundColor: Colors.purple[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.vertical_align_top),
            onPressed: () {
              HapticFeedback.lightImpact();
              scrollToTop();
            },
            tooltip: '滚动到顶部',
          ),
          IconButton(
            icon: const Icon(Icons.vertical_align_bottom),
            onPressed: () {
              HapticFeedback.lightImpact();
              scrollToBottom();
            },
            tooltip: '滚动到底部',
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: demoItems.length + 2, // +2 for header and footer
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildHeader();
              } else if (index == demoItems.length + 1) {
                return _buildFooter();
              } else {
                return _buildDemoItem(demoItems[index - 1], index - 1);
              }
            },
          ),

          // 滚动位置指示器
          Positioned(
            right: 16,
            top: 100,
            child: ScrollPositionIndicator(
              controller: scrollController,
              color: Colors.purple,
              width: 6,
              height: 80,
            ),
          ),

          // 浮动按钮
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.small(
                  heroTag: 'scroll_info',
                  onPressed: _showScrollInfo,
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.info, color: Colors.blue),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.small(
                  heroTag: 'clear_position',
                  onPressed: _clearScrollPosition,
                  backgroundColor: Colors.red[100],
                  child: const Icon(Icons.clear, color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToDetailPage(context),
        icon: const Icon(Icons.arrow_forward),
        label: const Text('进入详情页测试'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple[100]!, Colors.purple[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🚀 滚动位置保持演示',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '滚动到任意位置，然后点击"进入详情页测试"按钮。\n返回时将自动恢复到之前的滚动位置。',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.touch_app, color: Colors.purple, size: 20),
              SizedBox(width: 8),
              Text(
                '尝试滚动列表，体验位置保持功能',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDemoItem(String title, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('点击了: $title'),
                duration: const Duration(milliseconds: 800),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '点击测试交互效果',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 32),
          SizedBox(height: 8),
          Text(
            '🎉 恭喜！您已滚动到底部',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '现在可以测试滚动位置保持功能了',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ScrollTestDetailPage(),
      ),
    );
  }

  void _showScrollInfo() {
    final position = scrollController.hasClients ? scrollController.offset.toStringAsFixed(1) : '0.0';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('滚动位置信息'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('当前滚动位置: ${position}px'),
            const SizedBox(height: 8),
            Text('页面标识: $pageKey'),
            const SizedBox(height: 8),
            const Text('💡 这个位置会被自动保存'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _clearScrollPosition() {
    ScrollPositionManager().clearScrollPosition(pageKey);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('已清除保存的滚动位置'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// 测试用的详情页面
class ScrollTestDetailPage extends StatelessWidget {
  const ScrollTestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('测试详情页'),
        backgroundColor: Colors.orange[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            const Text(
              '这是一个测试详情页',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                '点击返回按钮，您会发现列表自动恢复到之前的滚动位置！',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('返回测试滚动位置保持'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
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
