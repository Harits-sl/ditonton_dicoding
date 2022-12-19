import 'package:core/utils/body_state_enum.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  BodyState _bodyState = BodyState.Movie;
  BodyState get bodyState => _bodyState;

  void changeToMovie() {
    _bodyState = BodyState.Movie;
    notifyListeners();
  }

  void changeToTv() {
    _bodyState = BodyState.Tv;
    notifyListeners();
  }
}
