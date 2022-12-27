part of 'movie_recommendation_cubit.dart';

@immutable
abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object?> get props => [];
}

class MovieRecommendationInitial extends MovieRecommendationState {}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationError extends MovieRecommendationState {
  const MovieRecommendationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class MovieRecommendationHasData extends MovieRecommendationState {
  const MovieRecommendationHasData(this.movies);

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];
}
