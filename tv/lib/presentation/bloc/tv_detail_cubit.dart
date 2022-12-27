import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  TvDetailCubit(this.getTvDetail) : super(TvDetailInitial());

  final GetTvDetail getTvDetail;

  void fetchTvDetail(int id) async {
    emit(TvDetailLoading());

    final detailResult = await getTvDetail.execute(id);

    detailResult.fold(
      (failure) {
        emit(TvDetailError(failure.message));
      },
      (tv) {
        emit(TvDetailHasData(tv));
      },
    );
  }
}
