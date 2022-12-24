import 'package:core/domain/entities/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';

part 'popular_tvs_state.dart';

class PopularTvsCubit extends Cubit<PopularTvsState> {
  PopularTvsCubit(
    this.getPopularTvs,
  ) : super(PopularTvsInitial());

  final GetPopularTvs getPopularTvs;

  void fetchPopularTvs() async {
    emit(PopularTvsLoading());

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        emit(PopularTvsError(failure.message));
      },
      (tvsData) {
        emit(PopularTvsHasData(tvsData));
      },
    );
  }
}
