import 'package:flutter/material.dart';

class TabBaseApp extends StatelessWidget {
  const TabBaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TabBar 示例',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar 示例'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: '首页'),
            Tab(icon: Icon(Icons.star), text: '收藏'),
            Tab(icon: Icon(Icons.person), text: '我的'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 第一个标签页内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.home, size: 80),
                const SizedBox(height: 20),
                const Text('首页内容', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('你点击了首页按钮')));
                  },
                  child: const Text('点击我'),
                ),
              ],
            ),
          ),

          // 第二个标签页内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, size: 80, color: Colors.amber),
                const SizedBox(height: 20),
                const Text('收藏内容', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.favorite, color: Colors.red),
                      title: Text('收藏项目 ${index + 1}'),
                      subtitle: Text('这是收藏的第 ${index + 1} 个项目的描述'),
                    );
                  },
                ),
              ],
            ),
          ),

          // 第三个标签页内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text('我的个人信息', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.person_outline),
                          title: Text('用户名'),
                          subtitle: Text('Flutter开发者'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('邮箱'),
                          subtitle: Text('example@flutter.dev'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('电话'),
                          subtitle: Text('123-456-7890'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
