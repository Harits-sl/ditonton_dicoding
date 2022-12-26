part of 'tv_watchlist_bloc.dart';

@immutable
abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistError extends TvWatchlistState {
  const TvWatchlistError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class TvWatchlistMessage extends TvWatchlistState {
  const TvWatchlistMessage(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class TvWatchlistStatus extends TvWatchlistState {
  const TvWatchlistStatus(this.isAddedToTvWatchlist);

  final bool isAddedToTvWatchlist;

  @override
  List<Object> get props => [isAddedToTvWatchlist];
}
