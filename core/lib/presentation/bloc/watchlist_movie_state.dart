part of 'watchlist_movie_cubit.dart';

@immutable
abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  const WatchlistMovieError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  const WatchlistMovieHasData(this.movies);

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];
}
