import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvDetail getTvDetail;

  TvDetailNotifier({required this.getTvDetail});

  late TvDetail _tv;
  TvDetail get tv => _tv;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvDetail(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    detailResult.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _state = RequestState.Loaded;
      _tv = data;
      notifyListeners();
    });
  }
}
