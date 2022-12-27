import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_recommendation_cubit_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationCubit tvRecommendationCubit;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationCubit = TvRecommendationCubit(mockGetTvRecommendations);
  });

  const tId = 1;

  final tTv = Tv(
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
  final tTvs = <Tv>[tTv];

  test('initial state should be empty', () {
    expect(tvRecommendationCubit.state, TvRecommendationInitial());
  });

  blocTest<TvRecommendationCubit, TvRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvs));
      return tvRecommendationCubit;
    },
    act: (cubit) => cubit.fetchTvRecommendation(tId),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationHasData(tTvs),
    ],
    verify: (cubit) {
      verify(mockGetTvRecommendations.execute(tId));
    },
  );

  blocTest<TvRecommendationCubit, TvRecommendationState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationCubit;
    },
    act: (cubit) => cubit.fetchTvRecommendation(tId),
    expect: () => [
      TvRecommendationLoading(),
      const TvRecommendationError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetTvRecommendations.execute(tId));
    },
  );
}
