import 'dart:math';

import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

///Class to hold data for itembuilder in Withbuilder app.
class ItemData {
  final Color color;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  ItemData(this.color, this.image, this.text1, this.text2, this.text3);
}

/// Example of LiquidSwipe with itemBuilder
class LiquidSwipePage extends StatefulWidget {
  const LiquidSwipePage({super.key});

  @override
  State<LiquidSwipePage> createState() => _WithBuilder();
}

class _WithBuilder extends State<LiquidSwipePage> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  List<ItemData> dataList = [
    ItemData(
      Colors.blue,
      "assets/images/home_1.png",
      "Hi",
      "It's Me",
      "Sahdeep",
    ),
    ItemData(
      Colors.deepPurpleAccent,
      "assets/images/home_2.png",
      "Take a",
      "Look At",
      "Liquid Swipe",
    ),
    ItemData(
      Colors.green,
      "assets/images/home_1.png",
      "Liked?",
      "Fork!",
      "Give Star!",
    ),
    ItemData(
      Colors.yellow,
      "assets/images/home_2.png",
      "Can be",
      "Used for",
      "Onboarding design",
    ),
    ItemData(
      Colors.pink,
      "assets/images/home_1.png",
      "Example",
      "of a page",
      "with Gesture",
    ),
    ItemData(
      Colors.red,
      "assets/images/home_2.png",
      "Do",
      "try it",
      "Thank you",
    ),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(0.0, 1.0 - ((page) - index).abs()),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(width: 8.0 * zoom, height: 8.0 * zoom),
        ),
      ),
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
        title: Text('My App'),
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(color: Colors.red, width: 1)),
        ),
      ),
      body: Stack(
        children: <Widget>[
          LiquidSwipe.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                color: dataList[index].color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      dataList[index].image,
                      height: 360,
                      fit: BoxFit.contain,
                    ),
                    Padding(padding: EdgeInsets.all(index != 4 ? 24.0 : 0)),
                    index == 4
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 70.0,
                            ),
                            child: ExampleSlider(),
                          )
                        : SizedBox.shrink(),
                    Column(
                      children: <Widget>[
                        Text(dataList[index].text1, style: WithPages.style),
                        Text(dataList[index].text2, style: WithPages.style),
                        Text(dataList[index].text3, style: WithPages.style),
                      ],
                    ),
                  ],
                ),
              );
            },
            positionSlideIcon: 0.8,
            slideIconWidget: Icon(Icons.arrow_back_ios),
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            fullTransitionValue: 880,
            enableSideReveal: true,
            preferDragFromRevealedArea: true,
            enableLoop: true,
            ignoreUserGestureWhileAnimating: true,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(dataList.length, _buildDot),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  liquidController.animateToPage(
                    page: dataList.length - 1,
                    duration: 700,
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: .01),
                  foregroundColor: Colors.black,
                ),
                child: Text("Skip to End"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  liquidController.jumpToPage(
                    page: liquidController.currentPage + 1 > dataList.length - 1 ? 0 : liquidController.currentPage + 1,
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.01),
                  foregroundColor: Colors.black,
                ),
                child: Text("Next"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}

///Example of App with LiquidSwipe by providing list of widgets
class WithPages extends StatefulWidget {
  static final style = TextStyle(
    fontSize: 30,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

  const WithPages({super.key});

  @override
  State<WithPages> createState() => _WithPages();
}

class _WithPages extends State<WithPages> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;
  final pages = [
    Container(
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/1.png', fit: BoxFit.cover),
          Padding(padding: EdgeInsets.all(24.0)),
          Column(
            children: <Widget>[
              Text("Hi", style: WithPages.style),
              Text("It's Me", style: WithPages.style),
              Text("Sahdeep", style: WithPages.style),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/1.png', fit: BoxFit.cover),
          Padding(padding: EdgeInsets.all(24.0)),
          Column(
            children: <Widget>[
              Text("Take a", style: WithPages.style),
              Text("look at", style: WithPages.style),
              Text("Liquid Swipe", style: WithPages.style),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/1.png', fit: BoxFit.cover),
          Padding(padding: EdgeInsets.all(24.0)),
          Column(
            children: <Widget>[
              Text("Liked?", style: WithPages.style),
              Text("Fork!", style: WithPages.style),
              Text("Give Star!", style: WithPages.style),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/1.png', fit: BoxFit.cover),
          Padding(padding: EdgeInsets.all(24.0)),
          Column(
            children: <Widget>[
              Text("Can be", style: WithPages.style),
              Text("Used for", style: WithPages.style),
              Text("Onboarding Design", style: WithPages.style),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/1.png', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: ExampleSlider(),
          ),
          Column(
            children: <Widget>[
              Text("Example", style: WithPages.style),
              Text("of a page", style: WithPages.style),
              Text("with Gesture", style: WithPages.style),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/1.png', fit: BoxFit.cover),
          Padding(padding: EdgeInsets.all(24.0)),
          Column(
            children: <Widget>[
              Text("Do", style: WithPages.style),
              Text("Try it", style: WithPages.style),
              Text("Thank You", style: WithPages.style),
            ],
          ),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(0.0, 1.0 - ((page) - index).abs()),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(width: 8.0 * zoom, height: 8.0 * zoom),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: pages,
              positionSlideIcon: 0.8,
              fullTransitionValue: 880,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              preferDragFromRevealedArea: true,
              enableSideReveal: true,
              ignoreUserGestureWhileAnimating: true,
              enableLoop: true,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pages.length, _buildDot),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.animateToPage(
                      page: pages.length - 1,
                      duration: 700,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: .01),
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Skip to End"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.jumpToPage(
                      page: liquidController.currentPage + 1 > pages.length - 1 ? 0 : liquidController.currentPage + 1,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.01),
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Next"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}

class ExampleSlider extends StatefulWidget {
  const ExampleSlider({super.key});

  @override
  State<ExampleSlider> createState() => _ExampleSliderState();
}

class _ExampleSliderState extends State<ExampleSlider> {
  double sliderVal = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: sliderVal,
      activeColor: Colors.white,
      inactiveColor: Colors.red,
      onChanged: (val) {
        setState(() {
          sliderVal = val;
        });
      },
    );
  }
}
