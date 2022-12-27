part of 'tv_watchlist_bloc.dart';

@immutable
abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnButtonAddTvWatchlistTapped extends TvWatchlistEvent {
  const OnButtonAddTvWatchlistTapped(this.tv);

  final TvDetail tv;

  @override
  List<Object> get props => [tv];
}

class OnButtonRemoveTvWatchlistTapped extends TvWatchlistEvent {
  const OnButtonRemoveTvWatchlistTapped(this.tv);

  final TvDetail tv;

  @override
  List<Object> get props => [tv];
}

class LoadTvWatchlistStatus extends TvWatchlistEvent {
  const LoadTvWatchlistStatus(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
