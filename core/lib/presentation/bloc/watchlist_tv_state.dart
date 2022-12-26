part of 'watchlist_tv_cubit.dart';

@immutable
abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object?> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvError extends WatchlistTvState {
  const WatchlistTvError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class WatchlistTvHasData extends WatchlistTvState {
  const WatchlistTvHasData(this.tvs);

  final List<Tv> tvs;

  @override
  List<Object> get props => [tvs];
}
