import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
  });

  late TvDetail _tv;
  TvDetail get tv => _tv;

  RequestState _detailState = RequestState.Empty;
  RequestState get detailState => _detailState;

  List<Tv> _tvRecommendations = <Tv>[];
  List<Tv> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvDetail(int id) async {
    _detailState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    final recommedationsResult = await getTvRecommendations.execute(id);

    detailResult.fold((failure) {
      _detailState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tv) {
      _recommendationState = RequestState.Loading;
      _tv = tv;
      notifyListeners();
      recommedationsResult.fold(
        (failure) {
          _recommendationState = RequestState.Error;
          _message = failure.message;
        },
        (recommendations) {
          _recommendationState = RequestState.Loaded;
          _tvRecommendations = recommendations;
        },
      );
      _detailState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
