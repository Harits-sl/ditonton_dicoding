import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/presentation/provider/now_playing_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tvs_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late NowPlayingTvsNotifier provider;
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    provider = NowPlayingTvsNotifier(
      getNowPlayingTvs: mockGetNowPlayingTvs,
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
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    provider.fetchNowPlayingTvs();
    // assert
    verify(mockGetNowPlayingTvs.execute());
  });

  test('should change state to Loading when usecase is called', () {
    // arrange
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    provider.fetchNowPlayingTvs();
    // assert
    expect(provider.state, RequestState.Loading);
  });

  test('should change movies when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await provider.fetchNowPlayingTvs();
    // assert
    expect(provider.state, RequestState.Loaded);
    expect(provider.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await provider.fetchNowPlayingTvs();
    // assert
    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
