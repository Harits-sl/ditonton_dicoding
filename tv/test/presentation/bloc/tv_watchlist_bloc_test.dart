import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistTv, RemoveWatchlistTv, GetWatchlistTvStatus])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;

  setUp(() {
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    tvWatchlistBloc = TvWatchlistBloc(
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
      getWatchlistTvStatus: mockGetWatchlistTvStatus,
    );
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(tvWatchlistBloc.state, TvWatchlistInitial());
  });

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [TvWatchlistStatus] when LoadTvWatchlistStatus called',
    build: () {
      when(mockGetWatchlistTvStatus.execute(tId)).thenAnswer((_) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const LoadTvWatchlistStatus(tId)),
    expect: () => [
      const TvWatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvStatus.execute(tId));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Status, Message] when OnButtonAddWatchlistTapped called',
    build: () {
      when(mockGetWatchlistTvStatus.execute(tId)).thenAnswer((_) async => true);
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return tvWatchlistBloc;
    },
    act: (bloc) {
      bloc.add(const LoadTvWatchlistStatus(tId));
      bloc.add(OnButtonAddTvWatchlistTapped(testTvDetail));
    },
    expect: () => [
      const TvWatchlistStatus(true),
      const TvWatchlistMessage('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvStatus.execute(tId));
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Status, Message] when OnButtonRemoveTvWatchlistTapped called',
    build: () {
      when(mockGetWatchlistTvStatus.execute(tId))
          .thenAnswer((_) async => false);
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return tvWatchlistBloc;
    },
    act: (bloc) {
      bloc.add(const LoadTvWatchlistStatus(tId));
      bloc.add(OnButtonRemoveTvWatchlistTapped(testTvDetail));
    },
    expect: () => [
      const TvWatchlistStatus(false),
      const TvWatchlistMessage('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvStatus.execute(tId));
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Error] when OnButtonAddWatchlistTapped failure',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return tvWatchlistBloc;
    },
    act: (bloc) {
      bloc.add(OnButtonAddTvWatchlistTapped(testTvDetail));
    },
    expect: () => [
      const TvWatchlistError('Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Error] when OnButtonRemoveWatchlistTapped failure',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return tvWatchlistBloc;
    },
    act: (bloc) {
      bloc.add(OnButtonRemoveTvWatchlistTapped(testTvDetail));
    },
    expect: () => [
      const TvWatchlistError('Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    },
  );
}
