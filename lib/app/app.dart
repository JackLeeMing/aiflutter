import 'package:aiflutter/app/app_pages.dart';
import 'package:aiflutter/models/section.dart';
import 'package:aiflutter/router/context_extension.dart';
import 'package:aiflutter/utils/camera.dart';
import 'package:aiflutter/utils/simple_scroll_manager.dart';
import 'package:aiflutter/widgets/dialog.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// 应用程序主入口页面 - iOS风格设置界面
/// 提供类似iOS系统设置的列表界面，包含分组和导航功能
class AppEntryPage extends StatefulWidget {
  const AppEntryPage({super.key});

  @override
  State<AppEntryPage> createState() => _AppEntryPageState();
}

class _AppEntryPageState extends State<AppEntryPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 保持页面状态

  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用，用于 AutomaticKeepAliveClientMixin
    return WindowFrameWidget(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            'AI & 爱',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 1,
          centerTitle: true,
        ),
        body: SmartScrollView(
          pageKey: 'app_entry_list',
          builder: (controller) => ListView.builder(
            key: const PageStorageKey<String>('settings_list'),
            controller: controller,
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: settingsSections.length,
            itemBuilder: (context, index) {
              final section = settingsSections[index];
              return _buildSection(section);
            },
          ),
        ),
      ),
    );
  }

  /// 构建设置分组
  Widget _buildSection(SettingsSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 分组标题
        if (section.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              section.title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
        // 设置项列表
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: section.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isLast = index == section.items.length - 1;
                return _buildSettingsItem(item, isLast);
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  /// 构建单个设置项
  Widget _buildSettingsItem(SettingsItem item, bool isLast) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleItemTap(item),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: isLast
                ? null
                : Border(
                    bottom: BorderSide(
                      color: Colors.grey[200]!,
                      width: 0.5,
                    ),
                  ),
          ),
          child: Row(
            children: [
              // 图标
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: item.iconColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item.icon,
                  size: 18,
                  color: item.iconColor,
                ),
              ),
              const SizedBox(width: 12),
              // 标题和副标题
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    if (item.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // 箭头图标
              if (item.hasArrow)
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// 处理设置项点击事件
  void _handleItemTap(SettingsItem item) {
    // 添加触觉反馈
    HapticFeedback.lightImpact();
    // 如果有自定义点击事件，也执行它
    final isCamera = item.isCamera;
    if (isCamera) {
      checkCameraPermission(context, okBack: () {
        showTDSuccessMessage(context, "正常调用系统相机!");
        _goNextPage(item);
      }, failBack: () {
        showTDWarningMessage(context, "无法调用系统相机!");
      });
    } else {
      _goNextPage(item);
    }
  }

  void _goNextPage(SettingsItem item) {
    if (item.onTap != null) {
      item.onTap!();
    } else {
      if (item.path != null && item.path != "") {
        context.push(item.path!);
      } else {
        context.goToFeature(item.title, context);
      }
    }
  }
}
