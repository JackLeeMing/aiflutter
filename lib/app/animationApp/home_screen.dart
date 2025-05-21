import 'package:aiflutter/app/animationApp/question_screen.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimationHomeScreen extends StatelessWidget {
  const AnimationHomeScreen({super.key});

  void toNextPage(BuildContext context) {
    // Show the question screen to start the game
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return QuestionScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation, // NEW
            secondaryAnimation: secondaryAnimation, // NEW
            child: child, // NEW
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('✏️', style: Theme.of(context).textTheme.displayLarge),
            Text(
              'Flutter Quiz',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                  ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const QuestionScreen(); // NEW
                  }), // NEW
                );
              },
              child: Text('New Game'),
            ),
          ],
        ),
      ),
    );
  }
}
