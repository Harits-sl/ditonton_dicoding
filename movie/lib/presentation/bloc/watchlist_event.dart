part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnButtonAddWatchlistTapped extends WatchlistEvent {
  const OnButtonAddWatchlistTapped(this.movie);

  final MovieDetail movie;

  @override
  List<Object> get props => [movie];
}

class OnButtonRemoveWatchlistTapped extends WatchlistEvent {
  const OnButtonRemoveWatchlistTapped(this.movie);

  final MovieDetail movie;

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends WatchlistEvent {
  const LoadWatchlistStatus(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
