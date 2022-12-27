import 'dart:async';

import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;
  final GetWatchlistTvStatus getWatchlistTvStatus;

  TvWatchlistBloc({
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
    required this.getWatchlistTvStatus,
  }) : super(TvWatchlistInitial()) {
    on<OnButtonAddTvWatchlistTapped>(_onButtonAddTvWatchlistTapped);
    on<OnButtonRemoveTvWatchlistTapped>(_onButtonRemoveTvWatchlistTapped);
    on<LoadTvWatchlistStatus>(_loadTvWatchlistStatus);
  }

  FutureOr<void> _onButtonAddTvWatchlistTapped(
    OnButtonAddTvWatchlistTapped event,
    Emitter<TvWatchlistState> emit,
  ) async {
    final result = await saveWatchlistTv.execute(event.tv);

    await result.fold(
      (failure) async {
        emit(TvWatchlistError(failure.message));
      },
      (successMessage) async {
        emit(TvWatchlistMessage(successMessage));
      },
    );

    LoadTvWatchlistStatus(event.tv.id);
  }

  FutureOr<void> _onButtonRemoveTvWatchlistTapped(
    OnButtonRemoveTvWatchlistTapped event,
    Emitter<TvWatchlistState> emit,
  ) async {
    final result = await removeWatchlistTv.execute(event.tv);

    await result.fold(
      (failure) async {
        emit(TvWatchlistError(failure.message));
      },
      (successMessage) async {
        emit(TvWatchlistMessage(successMessage));
      },
    );

    LoadTvWatchlistStatus(event.tv.id);
  }

  FutureOr<void> _loadTvWatchlistStatus(
    LoadTvWatchlistStatus event,
    Emitter<TvWatchlistState> emit,
  ) async {
    final result = await getWatchlistTvStatus.execute(event.id);
    emit(TvWatchlistStatus(result));
  }
}
