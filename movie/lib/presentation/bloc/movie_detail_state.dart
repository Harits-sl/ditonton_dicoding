part of 'movie_detail_cubit.dart';

@immutable
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  const MovieDetailError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  const MovieDetailHasData(this.movie);

  final MovieDetail movie;

  @override
  List<Object> get props => [movie];
}
