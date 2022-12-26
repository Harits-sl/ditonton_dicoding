import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  WatchlistMovieCubit(this.getWatchlistMovies) : super(WatchlistMovieInitial());

  final GetWatchlistMovies getWatchlistMovies;

  void fetchWatchlistMovies() async {
    emit(WatchlistMovieLoading());

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(WatchlistMovieError(failure.message));
      },
      (moviesData) {
        emit(WatchlistMovieHasData(moviesData));
      },
    );
  }
}
