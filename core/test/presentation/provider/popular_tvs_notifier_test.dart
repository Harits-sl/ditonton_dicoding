import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tvs.dart';
import 'package:core/presentation/provider/popular_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvs_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvsNotifier provider;
  late MockGetPopularTvs mockGetPopularTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvs = MockGetPopularTvs();
    provider = PopularTvsNotifier(
      getPopularTvs: mockGetPopularTvs,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvList = <Tv>[tTv];

  test('initialState should be Empty', () {
    expect(provider.state, equals(RequestState.Empty));
  });

  test('should get data from the usecase', () async {
    // arrange
    when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    provider.fetchPopularTvs();
    // assert
    verify(mockGetPopularTvs.execute());
  });

  test('should change state to Loading when usecase is called', () {
    // arrange
    when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    provider.fetchPopularTvs();
    // assert
    expect(provider.state, RequestState.Loading);
  });

  test('should change movies when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await provider.fetchPopularTvs();
    // assert
    expect(provider.state, RequestState.Loaded);
    expect(provider.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await provider.fetchPopularTvs();
    // assert
    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}