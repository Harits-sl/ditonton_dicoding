import 'package:core/domain/entities/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/get_now_playing_tvs.dart';

part 'now_playing_tvs_state.dart';

class NowPlayingTvsCubit extends Cubit<NowPlayingTvsState> {
  NowPlayingTvsCubit(
    this.getNowPlayingTvs,
  ) : super(NowPlayingTvsInitial());

  final GetNowPlayingTvs getNowPlayingTvs;

  void fetchNowPlayingTvs() async {
    emit(NowPlayingTvsLoading());

    final result = await getNowPlayingTvs.execute();
    result.fold(
      (failure) {
        emit(NowPlayingTvsError(failure.message));
      },
      (tvsData) {
        emit(NowPlayingTvsHasData(tvsData));
      },
    );
  }
}
