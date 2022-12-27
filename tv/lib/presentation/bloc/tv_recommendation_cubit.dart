import 'package:core/domain/entities/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

part 'tv_recommendation_state.dart';

class TvRecommendationCubit extends Cubit<TvRecommendationState> {
  TvRecommendationCubit(this.getTvRecommendations)
      : super(TvRecommendationInitial());

  final GetTvRecommendations getTvRecommendations;

  void fetchTvRecommendation(int id) async {
    emit(TvRecommendationLoading());

    final recommendationResult = await getTvRecommendations.execute(id);

    recommendationResult.fold(
      (failure) {
        emit(TvRecommendationError(failure.message));
      },
      (tvs) {
        emit(TvRecommendationHasData(tvs));
      },
    );
  }
}
