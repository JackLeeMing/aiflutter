import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class BoxTransformApp extends StatelessWidget {
  const BoxTransformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Box Transform Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Rect rect = Rect.fromCenter(
    center: MediaQuery.of(context).size.center(Offset.zero),
    width: 200,
    height: 150,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
