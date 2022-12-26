import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_tv_state.dart';

class WatchlistTvCubit extends Cubit<WatchlistTvState> {
  WatchlistTvCubit(this.getWatchlistTvs) : super(WatchlistTvInitial());

  final GetWatchlistTvs getWatchlistTvs;

  void fetchWatchlistTvs() async {
    emit(WatchlistTvLoading());

    final result = await getWatchlistTvs.execute();
    result.fold(
      (failure) {
        emit(WatchlistTvError(failure.message));
      },
      (tvsData) {
        emit(WatchlistTvHasData(tvsData));
      },
    );
  }
}
