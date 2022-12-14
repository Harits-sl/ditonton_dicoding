part of 'now_playing_tvs_cubit.dart';

// @immutable
abstract class NowPlayingTvsState extends Equatable {
  const NowPlayingTvsState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvsInitial extends NowPlayingTvsState {}

class NowPlayingTvsLoading extends NowPlayingTvsState {}

class NowPlayingTvsError extends NowPlayingTvsState {
  final String message;

  const NowPlayingTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvsHasData extends NowPlayingTvsState {
  final List<Tv> result;

  const NowPlayingTvsHasData(this.result);

  @override
  List<Object> get props => [result];
}
