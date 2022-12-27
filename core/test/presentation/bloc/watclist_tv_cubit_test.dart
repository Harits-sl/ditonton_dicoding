import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watclist_tv_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late WatchlistTvCubit watchlistTvCubit;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    watchlistTvCubit = WatchlistTvCubit(mockGetWatchlistTvs);
  });

  test('initial state should be empty', () {
    expect(watchlistTvCubit.state, WatchlistTvInitial());
  });

  blocTest<WatchlistTvCubit, WatchlistTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return watchlistTvCubit;
    },
    act: (cubit) => cubit.fetchWatchlistTvs(),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvHasData([testWatchlistTv]),
    ],
    verify: (cubit) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<WatchlistTvCubit, WatchlistTvState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistTvCubit;
    },
    act: (cubit) => cubit.fetchWatchlistTvs(),
    expect: () => [
      WatchlistTvLoading(),
      const WatchlistTvError("Can't get data"),
    ],
    verify: (cubit) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
}
