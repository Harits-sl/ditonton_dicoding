part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  const WatchlistError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class WatchlistMessage extends WatchlistState {
  const WatchlistMessage(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class WatchlistStatus extends WatchlistState {
  const WatchlistStatus(this.isAddedToWatchlist);

  final bool isAddedToWatchlist;

  @override
  List<Object> get props => [isAddedToWatchlist];
}
