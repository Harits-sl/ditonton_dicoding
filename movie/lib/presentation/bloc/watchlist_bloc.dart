import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  WatchlistBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus,
  }) : super(WatchlistInitial()) {
    on<OnButtonAddWatchlistTapped>(_onButtonAddWatchlistTapped);
    on<OnButtonRemoveWatchlistTapped>(_onButtonRemoveWatchlistTapped);
    on<LoadWatchlistStatus>(_loadWatchlistStatus);
  }

  FutureOr<void> _onButtonAddWatchlistTapped(
    OnButtonAddWatchlistTapped event,
    Emitter<WatchlistState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movie);

    await result.fold(
      (failure) async {
        emit(WatchlistError(failure.message));
      },
      (successMessage) async {
        emit(WatchlistMessage(successMessage));
      },
    );

    LoadWatchlistStatus(event.movie.id);
  }

  FutureOr<void> _onButtonRemoveWatchlistTapped(
    OnButtonRemoveWatchlistTapped event,
    Emitter<WatchlistState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movie);

    await result.fold(
      (failure) async {
        emit(WatchlistError(failure.message));
      },
      (successMessage) async {
        emit(WatchlistMessage(successMessage));
      },
    );

    LoadWatchlistStatus(event.movie.id);
  }

  FutureOr<void> _loadWatchlistStatus(
    LoadWatchlistStatus event,
    Emitter<WatchlistState> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(WatchlistStatus(result));
  }
}
