import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'now_playing_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late NowPlayingTvsCubit nowPlayingTvsCubit;
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    nowPlayingTvsCubit = NowPlayingTvsCubit(mockGetNowPlayingTvs);
  });

  final tTvModel = Tv(
    posterPath: '/jeGtaMwGxPmQN5xM4ClnwPQcNQz.jpg',
    popularity: 1397.308,
    id: 119051,
    backdropPath: '/9DpB6wC1iY5jxLz91RT8tIIsXaf.jpg',
    voteAverage: 8.8,
    overview:
        "Wednesday Addams is sent to Nevermore Academy, a bizarre boarding school where she attempts to master her psychic powers, stop a monstrous killing spree of the town citizens, and solve the supernatural mystery that affected her family 25 years ago - all while navigating her new relationships.",
    firstAirDate: '2022-11-23',
    genreIds: const [10765, 9648, 35],
    voteCount: 686,
    name: 'Wednesdayy',
    originalName: 'Wednesdayy',
  );
  final tTvList = <Tv>[tTvModel];

  test('initial state should be empty', () {
    expect(nowPlayingTvsCubit.state, NowPlayingTvsInitial());
  });

  blocTest<NowPlayingTvsCubit, NowPlayingTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return nowPlayingTvsCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingTvs(),
    expect: () => [
      NowPlayingTvsLoading(),
      NowPlayingTvsHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvs.execute());
    },
  );

  blocTest<NowPlayingTvsCubit, NowPlayingTvsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvsCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingTvs(),
    expect: () => [
      NowPlayingTvsLoading(),
      const NowPlayingTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvs.execute());
    },
  );
}
