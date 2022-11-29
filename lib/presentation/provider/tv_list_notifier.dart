import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTvs = <Tv>[];
  List<Tv> get nowPlayingTvs => _nowPlayingTvs;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  });

  final GetNowPlayingTvs getNowPlayingTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  Future<void> fetchNowPlayingTvs() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvs.execute();
    result.fold((failure) {
      _nowPlayingState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvsData) {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingTvs = tvsData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTvs() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold((failure) {
      _popularState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvsData) {
      _popularState = RequestState.Loaded;
      _popularTvs = tvsData;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold((failure) {
      _topRatedState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvsData) {
      _topRatedState = RequestState.Loaded;
      _topRatedTvs = tvsData;
      notifyListeners();
    });
  }
}
