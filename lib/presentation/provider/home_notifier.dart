import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';

enum Body { Movie, Tv }

class HomeNotifier extends ChangeNotifier {
  Body _body = Body.Movie;
  Body get body => _body;

  set setIndex(Body newValue) {
    _body = newValue;
  }

  Widget getBody() {
    switch (_body) {
      case Body.Movie:
        return HomeMoviePage();
      default:
        return HomeMoviePage();
    }
  }
}
