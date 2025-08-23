import 'package:aiflutter/router/context_extension.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'movie/animated_pages.dart';
import 'movie/image_slider.dart';
import 'movie/movie.dart';
import 'movie/movie_button.dart';
import 'movie/movie_details.dart';

class MovieAppPage extends StatefulWidget {
  const MovieAppPage({super.key});

  @override
  State<MovieAppPage> createState() => _MovieAppHomeState();
}

class _MovieAppHomeState extends State<MovieAppPage> {
  late PageController _pageController;
  List<Movie> movies = [];
  int currentIndex = 0;
  double pageValue = 0.0;

  @override
  void initState() {
    super.initState();
    movies = rawData
        .map(
          (data) => Movie(
            title: data["title"],
            index: data["index"],
            image: data["image"],
          ),
        )
        .toList();
    _pageController = PageController(
      initialPage: currentIndex,
      viewportFraction: 0.8,
    )..addListener(() {
        setState(() {
          pageValue = _pageController.page!;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    final reversedMovieList = movies.reversed.toList();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Stack(
              children: reversedMovieList.map((movie) {
                return ImageSlider(
                  pageValue: pageValue,
                  image: movie.image,
                  index: movie.index - 1,
                );
              }).toList(),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 0.8]),
              ),
            ),
            AnimatedPages(
              pageValue: pageValue,
              pageController: _pageController,
              pageCount: movies.length,
              onPageChangeCallback: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              child: (index, _) => MovieDetails(
                movies[index],
              ),
            ),
            const Positioned(
              bottom: 32.0,
              left: 0.0,
              right: 0.0,
              child: MovieButton(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => goBack(),
          tooltip: '返回',
          mini: true,
          elevation: 4,
          shape: CircleBorder(),
          backgroundColor: Color.fromARGB(255, 64, 238, 151),
          foregroundColor: Colors.yellow,
          child: const Icon(Icons.arrow_back_sharp, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }

  void goBack() {
    context.goBack();
  }
}
