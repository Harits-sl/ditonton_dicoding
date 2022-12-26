part of 'tv_recommendation_cubit.dart';

@immutable
abstract class TvRecommendationState extends Equatable {
  const TvRecommendationState();

  @override
  List<Object?> get props => [];
}

class TvRecommendationInitial extends TvRecommendationState {}

class TvRecommendationLoading extends TvRecommendationState {}

class TvRecommendationError extends TvRecommendationState {
  const TvRecommendationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class TvRecommendationHasData extends TvRecommendationState {
  const TvRecommendationHasData(this.tvs);

  final List<Tv> tvs;

  @override
  List<Object> get props => [tvs];
}
