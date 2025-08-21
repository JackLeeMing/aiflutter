import 'package:aiflutter/router/app_routes.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        appBar: AppBar(title: const Text('爱心+烟花')),
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
        appBar: AppBar(title: const Text('GeometryReader')),
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
        appBar: AppBar(title: const Text('作文灵感')),
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
        appBar: AppBar(title: const Text('口算题')),
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
        appBar: AppBar(title: const Text('古诗词')),
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
        appBar: AppBar(title: const Text('科学实验')),
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
        appBar: AppBar(title: const Text('阅读书单')),
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
        appBar: AppBar(title: const Text('英语自我介绍')),
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
