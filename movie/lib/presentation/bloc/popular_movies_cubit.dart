import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit(
    this.getPopularMovies,
  ) : super(PopularMoviesInitial());

  final GetPopularMovies getPopularMovies;

  void fetchPopularMovies() async {
    emit(PopularMoviesLoading());

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        emit(PopularMoviesError(failure.message));
      },
      (moviesData) {
        emit(PopularMoviesHasData(moviesData));
      },
    );
  }
}
