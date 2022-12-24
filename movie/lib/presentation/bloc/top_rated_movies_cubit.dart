import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  TopRatedMoviesCubit(
    this.getTopRatedMovies,
  ) : super(TopRatedMoviesInitial());

  final GetTopRatedMovies getTopRatedMovies;

  Future<void> fetchTopRatedMovies() async {
    emit(TopRatedMoviesLoading());

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(TopRatedMoviesError(failure.message));
      },
      (moviesData) {
        emit(TopRatedMoviesHasData(moviesData));
      },
    );
  }
}
