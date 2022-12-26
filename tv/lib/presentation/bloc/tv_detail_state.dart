part of 'tv_detail_cubit.dart';

@immutable
abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object?> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  const TvDetailError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvDetailState {
  const TvDetailHasData(this.tv);

  final TvDetail tv;

  @override
  List<Object> get props => [tv];
}
