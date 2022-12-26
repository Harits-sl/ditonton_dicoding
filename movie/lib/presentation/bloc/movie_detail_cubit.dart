import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(this.getMovieDetail) : super(MovieDetailInitial());

  final GetMovieDetail getMovieDetail;

  void fetchMovieDetail(int id) async {
    emit(MovieDetailLoading());

    final detailResult = await getMovieDetail.execute(id);

    detailResult.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (movie) {
        emit(MovieDetailHasData(movie));
      },
    );
  }
}
