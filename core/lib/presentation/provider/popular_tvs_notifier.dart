import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tvs.dart';
import 'package:flutter/material.dart';

class PopularTvsNotifier extends ChangeNotifier {
  PopularTvsNotifier({
    required this.getPopularTvs,
  });
  final GetPopularTvs getPopularTvs;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = <Tv>[];
  List<Tv> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvsData) {
      _state = RequestState.Loaded;
      _tvs = tvsData;
      notifyListeners();
    });
  }
}
