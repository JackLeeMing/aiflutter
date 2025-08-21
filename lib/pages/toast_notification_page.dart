import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

// flutter_easyloading
//
class ToastnotificationPage extends StatefulWidget {
  const ToastnotificationPage({super.key});

  @override
  State<StatefulWidget> createState() => _ToastnotificationPageState();
}

class _ToastnotificationPageState extends State<ToastnotificationPage> {
  String _selectedOption = 'None'; // 用于显示当前选中的选项
  bool _switchValue = true;

  void onBtn1Click(BuildContext context) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      title: Text('Hello, world!'),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  onCustomClick0(BuildContext context) {
    toastification.show(
      context: context,
      title: Text('Hello, world - 0!'),
      // .... Other parameters
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return RotationTransition(
          turns: animation,
          child: child,
        );
      },
    );
  }

  void onCustomClick1(BuildContext context) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text('Hello, World 1!'),
      // you can also use RichText widget for title and description parameters
      description: RichText(text: const TextSpan(text: 'This is a sample toast message. ')),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.check),
      showIcon: true, // show or hide the icon
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (context, onClose) {
          return OutlinedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Close'),
          );
        },
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) => print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) => print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
    );
  }

  void onCustomClick2(BuildContext context) {
    toastification.showCustom(
      context: context, // optional if you use ToastificationWrapper
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topRight,
      builder: (BuildContext context, ToastificationItem holder) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue,
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Custom Toast', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('This is a custom toast message!', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Perform an action when the button is pressed
                    },
                    child: const Text('Do Something'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Toast Notification"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedOption = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('你选择了: $value')),
              );
            },
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "Option A",
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text("选项 A"),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: "Option B",
                child: Row(
                  children: [
                    Icon(Icons.home),
                    SizedBox(width: 8),
                    Text("选项 B"),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: "Option C",
                child: Text("选项 C"),
              ),
            ],
            // 外观
            icon: const Icon(Icons.more_vert), // 自定义按钮的图标，如果为空则默认为三点图标
            tooltip: '更多选项', // 长按时显示的提示文本
            elevation: 8.0, // 菜单的阴影高度
            color: Colors.white, // 菜单的背景颜色
            shape: RoundedRectangleBorder(
              // 菜单的形状
              borderRadius: BorderRadius.circular(10.0),
            ),
            // offset: Offset(0, 50), // 菜单相对于按钮的偏移量
            // initialValue: 'Option A', // 初始选中的值，如果存在，则该项会有一个默认选中状态
          )
        ],
        flexibleSpace: SizedBox(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.pink, Colors.purple, Colors.deepOrange],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                // iOS 风格按钮
                onPressed: () {},
                child: const Text('Cupertino 按钮'),
              ),
              const SizedBox(height: 20),
              CupertinoSwitch(
                // iOS 风格开关
                value: _switchValue,
                onChanged: (bool value) {
                  // 处理开关状态变化
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                '当前选中: $_selectedOption',
                style: const TextStyle(fontSize: 24),
              ),
              Text('ElevatedButton (浮动按钮)'),
              ElevatedButton(
                onPressed: () {
                  onBtn1Click(context);
                },
                child: Text("按钮一"),
              ),
              SizedBox(height: 10),
              Text("FilledButton (填充按钮):"),
              FilledButton(
                onPressed: () {
                  onCustomClick0(context);
                },
                child: Text("按钮二"),
              ),
              SizedBox(height: 10),
              Text("FilledButton.tonal (色调填充按钮)"),
              FilledButton.tonal(
                onPressed: () {
                  onCustomClick1(context);
                },
                child: Text("按钮三"),
              ),
              SizedBox(height: 10),
              Text("OutlinedButton (边框按钮)"),
              OutlinedButton(
                onPressed: () {
                  onCustomClick2(context);
                },
                child: Text("按钮四"),
              ),
              SizedBox(height: 10),
              Text("TextButton (文本按钮)"),
              TextButton(
                onPressed: () {
                  onCustomClick2(context);
                },
                child: Text("按钮五"),
              ),
              SizedBox(height: 10),
              Text("IconButton (图标按钮)"),
              IconButton(
                onPressed: () {
                  onCustomClick2(context);
                },
                icon: Icon(Icons.abc),
              ),
              SizedBox(height: 10),
              Text("TFloatingActionButton (悬浮操作按钮)"),
              FloatingActionButton(
                onPressed: () {
                  onCustomClick2(context);
                },
                child: Icon(Icons.add),
              ),
              SizedBox(height: 10),
              Text("DropdownButton (下拉按钮)"),
              DropdownButton(
                items: [
                  DropdownMenuItem(value: 1, child: Text('选项一')),
                  DropdownMenuItem(value: 2, child: Text('选项二')),
                ],
                onChanged: (value) {},
                hint: Text("请选择"),
              ),
              SizedBox(height: 10),
              Text("DropdownButton (下拉按钮)"),
              PopupMenuButton<String>(
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: "Option A",
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 8),
                        Text("选项 A"),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<String>(
                    value: "Option B",
                    child: Row(
                      children: [
                        Icon(Icons.home),
                        SizedBox(width: 8),
                        Text("选项 B"),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: "Option C",
                    child: Text("选项 C"),
                  ),
                ],
                // 外观
                icon: const Icon(Icons.more_vert), // 自定义按钮的图标，如果为空则默认为三点图标
                tooltip: '更多选项', // 长按时显示的提示文本
                elevation: 8.0, // 菜单的阴影高度
                color: Colors.white, // 菜单的背景颜色
                shape: RoundedRectangleBorder(
                  // 菜单的形状
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // offset: Offset(0, 50), // 菜单相对于按钮的偏移量
                // initialValue: 'Option A', // 初始选中的值，如果存在，则该项会有一个默认选中状态
              ),
            ],
          ),
        ),
      ),
    );
  }
}
