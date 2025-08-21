import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class BoxTransformPage extends StatefulWidget {
  const BoxTransformPage({super.key});

  @override
  State<BoxTransformPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BoxTransformPage> {
  late Rect rect = Rect.fromCenter(
    center: MediaQuery.of(context).size.center(Offset.zero),
    width: 200,
    height: 150,
  );

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BoxTransform"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          TransformableBox(
            rect: rect,
            clampingRect: Offset.zero & MediaQuery.sizeOf(context),
            onChanged: (result, event) {
              setState(() {
                rect = result.rect;
              });
            },
            contentBuilder: (context, rect, flip) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/welcome.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
