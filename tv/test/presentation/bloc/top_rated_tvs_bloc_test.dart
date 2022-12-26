import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TopRatedTvsCubit topRatedTvsCubit;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvsCubit = TopRatedTvsCubit(mockGetTopRatedTvs);
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
    expect(topRatedTvsCubit.state, TopRatedTvsInitial());
  });

  blocTest<TopRatedTvsCubit, TopRatedTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return topRatedTvsCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTvs(),
    expect: () => [
      TopRatedTvsLoading(),
      TopRatedTvsHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );

  blocTest<TopRatedTvsCubit, TopRatedTvsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvsCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTvs(),
    expect: () => [
      TopRatedTvsLoading(),
      const TopRatedTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );
}
