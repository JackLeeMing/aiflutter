import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ios_presentation_styles.dart';

/// iOS展示样式演示页面
/// 展示 FullScreenCover 和 Sheet 的使用方式和特点
class PresentationDemoPage extends StatelessWidget {
  const PresentationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('iOS展示样式演示'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 页面介绍
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[50]!, Colors.purple[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📱 iOS展示样式',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '体验iOS风格的FullScreenCover和Sheet展示样式，了解它们的使用场景和交互特点。',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // FullScreenCover 展示卡片
            _buildPresentationCard(
              context,
              title: 'FullScreen Cover',
              subtitle: '全屏覆盖展示',
              description: '完全覆盖当前界面，提供沉浸式体验。适合展示重要内容、媒体预览或独立的功能模块。',
              icon: FontAwesomeIcons.expand,
              color: Colors.cyan,
              features: [
                '🎯 全屏覆盖显示',
                '✨ 从底部滑入动画',
                '🎨 深色主题设计',
                '👆 支持手势关闭',
                '🔄 可自定义动画效果',
              ],
              onPressed: () => IOSFullScreenCover.show(context),
            ),

            const SizedBox(height: 20),

            // Sheet 展示卡片
            _buildPresentationCard(
              context,
              title: 'Sheet Modal',
              subtitle: '底部弹出表单',
              description: '从底部弹出的模态界面，保持上下文可见。适合设置选项、表单输入或快速操作。',
              icon: FontAwesomeIcons.rectangleList,
              color: Colors.pink,
              features: [
                '📋 底部弹出设计',
                '🎛️ 支持交互控件',
                '📏 可调节高度',
                '👋 拖拽手势支持',
                '⚡ 快速访问操作',
              ],
              onPressed: () => IOSSheet.show(context),
            ),

            const SizedBox(height: 24),

            // 对比表格
            _buildComparisonTable(),

            const SizedBox(height: 24),

            // 使用建议
            _buildUsageGuidelines(),

            const SizedBox(height: 24),

            // 快速测试区域
            _buildQuickTestArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPresentationCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required Color color,
    required List<String> features,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, color.withValues(alpha: 0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题区域
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 描述
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // 特性列表
            Column(
              children: features
                  .map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Text(
                              feature,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 20),

            // 体验按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  onPressed();
                },
                icon: Icon(Icons.play_arrow),
                label: Text('体验 $title'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 特性对比',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: Colors.grey[300]!, width: 1),
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        '特性',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'FullScreen Cover',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Sheet Modal',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                _buildTableRow('覆盖范围', '全屏覆盖', '部分覆盖'),
                _buildTableRow('上下文', '完全隐藏', '部分可见'),
                _buildTableRow('交互方式', '沉浸式', '快速操作'),
                _buildTableRow('适用场景', '重要内容展示', '设置和表单'),
                _buildTableRow('关闭方式', '按钮或手势', '拖拽或按钮'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String feature, String fullScreen, String sheet) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            feature,
            style: const TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            fullScreen,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            sheet,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildUsageGuidelines() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '💡 使用建议',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildGuideline(
              '🎯 FullScreen Cover 适用于：',
              [
                '• 媒体预览（图片、视频）',
                '• 独立功能模块',
                '• 重要信息展示',
                '• 需要用户专注的内容',
              ],
              Colors.cyan,
            ),
            const SizedBox(height: 16),
            _buildGuideline(
              '📋 Sheet Modal 适用于：',
              [
                '• 设置和配置选项',
                '• 表单输入',
                '• 快速操作菜单',
                '• 选择器和筛选',
              ],
              Colors.pink,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideline(String title, List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            )),
      ],
    );
  }

  Widget _buildQuickTestArea(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🚀 快速测试',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => IOSFullScreenCover.show(context),
                    icon: const Icon(FontAwesomeIcons.expand),
                    label: const Text('全屏覆盖'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.cyan,
                      side: const BorderSide(color: Colors.cyan),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => IOSSheet.show(context),
                    icon: const Icon(FontAwesomeIcons.rectangleList),
                    label: const Text('底部表单'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.pink,
                      side: const BorderSide(color: Colors.pink),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
