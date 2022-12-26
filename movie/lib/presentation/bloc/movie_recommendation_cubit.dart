import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'movie_recommendation_state.dart';

class MovieRecommendationCubit extends Cubit<MovieRecommendationState> {
  MovieRecommendationCubit(this.getMovieRecommendations)
      : super(MovieRecommendationInitial());

  final GetMovieRecommendations getMovieRecommendations;

  void fetchMovieRecommendation(int id) async {
    emit(MovieRecommendationLoading());

    final recommendationResult = await getMovieRecommendations.execute(id);

    recommendationResult.fold(
      (failure) {
        emit(MovieRecommendationError(failure.message));
      },
      (movies) {
        emit(MovieRecommendationHasData(movies));
      },
    );
  }
}
