import 'package:ditonton/common/body_state_enum.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  BodyState _bodyState = BodyState.Movie;
  BodyState get bodyState => _bodyState;

  set setBodyState(BodyState newValue) {
    _bodyState = newValue;
    notifyListeners();
  }
}
