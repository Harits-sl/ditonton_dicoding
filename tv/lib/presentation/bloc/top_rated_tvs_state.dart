part of 'top_rated_tvs_cubit.dart';

@immutable
abstract class TopRatedTvsState extends Equatable {
  const TopRatedTvsState();

  @override
  List<Object> get props => [];
}

class TopRatedTvsInitial extends TopRatedTvsState {}

class TopRatedTvsLoading extends TopRatedTvsState {}

class TopRatedTvsError extends TopRatedTvsState {
  final String message;

  const TopRatedTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvsHasData extends TopRatedTvsState {
  final List<Tv> result;

  const TopRatedTvsHasData(this.result);

  @override
  List<Object> get props => [result];
}
