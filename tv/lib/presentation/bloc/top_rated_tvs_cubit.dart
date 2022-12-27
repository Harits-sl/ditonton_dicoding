import 'package:core/domain/entities/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';

part 'top_rated_tvs_state.dart';

class TopRatedTvsCubit extends Cubit<TopRatedTvsState> {
  TopRatedTvsCubit(
    this.getTopRatedTvs,
  ) : super(TopRatedTvsInitial());

  final GetTopRatedTvs getTopRatedTvs;

  void fetchTopRatedTvs() async {
    emit(TopRatedTvsLoading());

    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        emit(TopRatedTvsError(failure.message));
      },
      (tvsData) {
        emit(TopRatedTvsHasData(tvsData));
      },
    );
  }
}
