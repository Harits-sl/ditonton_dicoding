import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  NowPlayingMoviesCubit(
    this.getNowPlayingMovies,
  ) : super(NowPlayingMoviesInitial());

  final GetNowPlayingMovies getNowPlayingMovies;

  void fetchNowPlayingMovies() async {
    emit(NowPlayingMoviesLoading());

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(NowPlayingMoviesError(failure.message));
      },
      (moviesData) {
        emit(NowPlayingMoviesHasData(moviesData));
      },
    );
  }
}
