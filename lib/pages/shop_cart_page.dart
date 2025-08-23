import 'package:aiflutter/utils/colors.dart';
import 'package:flutter/material.dart';

class AddToCartAnimationPage extends StatefulWidget {
  const AddToCartAnimationPage({super.key});

  @override
  State<AddToCartAnimationPage> createState() => _AddToCartAnimationPageState();
}

class _AddToCartAnimationPageState extends State<AddToCartAnimationPage> {
  final GlobalKey _cartKey = GlobalKey();
  final GlobalKey _productKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  final ValueNotifier<int> _itemCount = ValueNotifier<int>(0);

  @override
  void dispose() {
    _itemCount.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _startAnimation() {
    if (_productKey.currentContext == null || _cartKey.currentContext == null) {
      return;
    }

    // 如果动画正在进行，则不重复触发
    if (_overlayEntry != null) {
      return;
    }

    final RenderBox productBox = _productKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox cartBox = _cartKey.currentContext!.findRenderObject() as RenderBox;

    final Offset startPosition = productBox.localToGlobal(Offset.zero);
    final Offset endPosition = cartBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return TweenAnimationBuilder<Offset>(
          tween: Tween<Offset>(begin: startPosition, end: endPosition),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          builder: (context, position, child) {
            final double progress = (position.dx - startPosition.dx) / (endPosition.dx - startPosition.dx);
            final double opacity = 1.0 - progress;
            final double size = 20.0 * (1.0 - progress * 0.5);

            return Positioned(
              left: position.dx,
              top: position.dy,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
          onEnd: () {
            _overlayEntry?.remove();
            _overlayEntry = null;
          },
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _onAddToCart() {
    _startAnimation();
    _itemCount.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('购物车动画'),
        actions: [
          Stack(
            children: [
              IconButton(
                key: _cartKey,
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              ValueListenableBuilder<int>(
                valueListenable: _itemCount,
                builder: (context, count, child) {
                  if (count > 0) {
                    return Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              key: _productKey,
              leading: Container(width: 50, height: 50, color: Colors.green),
              title: const Text('商品名称'),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: _onAddToCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MultiProductAddToCartPage extends StatefulWidget {
  const MultiProductAddToCartPage({super.key});

  @override
  State<MultiProductAddToCartPage> createState() => _MultiProductAddToCartPageState();
}

class _MultiProductAddToCartPageState extends State<MultiProductAddToCartPage> {
  final GlobalKey _cartKey = GlobalKey();
  final Map<int, GlobalKey> _productKeys = {};
  OverlayEntry? _overlayEntry;
  final ValueNotifier<int> _itemCount = ValueNotifier<int>(0);

  @override
  void dispose() {
    _itemCount.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _startAnimation(int productIndex) {
    final GlobalKey? productKey = _productKeys[productIndex];
    if (productKey == null || _cartKey.currentContext == null || productKey.currentContext == null) {
      return;
    }

    if (_overlayEntry != null) {
      return;
    }

    final RenderBox productBox = productKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox cartBox = _cartKey.currentContext!.findRenderObject() as RenderBox;

    final ps = productBox.localToGlobal(Offset.zero);

    final Offset startPosition = Offset(ps.dx + 38, ps.dy);
    final Offset endPosition = cartBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return TweenAnimationBuilder<Offset>(
          tween: Tween<Offset>(begin: startPosition, end: endPosition),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          builder: (context, position, child) {
            final double progress = (position.dy - startPosition.dy) / (endPosition.dy - startPosition.dy);
            final double opacity = 1.0 - progress;
            final double size = 25.0 * (1.0 - progress * 0.25);

            return Positioned(
              left: position.dx,
              top: position.dy,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
          onEnd: () {
            _overlayEntry?.remove();
            _overlayEntry = null;
          },
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _onAddToCart(int index) {
    _startAnimation(index);
    _itemCount.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('多商品购物车动画'),
        actions: [
          Stack(
            children: [
              IconButton(
                key: _cartKey,
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              ValueListenableBuilder<int>(
                valueListenable: _itemCount,
                builder: (context, count, child) {
                  if (count > 0) {
                    return Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          _productKeys.putIfAbsent(index, () => GlobalKey());
          return Column(
            children: [
              ListTile(
                key: _productKeys[index],
                leading: Container(width: 50, height: 50, color: randomColor()),
                title: Text('商品 $index'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () => _onAddToCart(index),
                ),
              ),
              const Divider(
                height: 10, // 分隔线的高度
                thickness: 1, // 分隔线的粗细
                indent: 16, // 左侧缩进
                endIndent: 16, // 右侧缩进
                // color: Colors.grey.shade500,
              ),
            ],
          );
        },
      ),
    );
  }
}
