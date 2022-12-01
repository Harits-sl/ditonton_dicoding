import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
      // verify(mockGetMovieRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 2);
    });

    // test('should change recommendation movies when data is gotten successfully',
    //     () async {
    //   // arrange
    //   _arrangeUsecase();
    //   // act
    //   await provider.fetchMovieDetail(tId);
    //   // assert
    //   expect(provider.movieState, RequestState.Loaded);
    //   expect(provider.movieRecommendations, tMovies);
    // });
  });

  // group('Get Movie Recommendations', () {
  //   test('should get data from the usecase', () async {
  //     // arrange
  //     _arrangeUsecase();
  //     // act
  //     await provider.fetchMovieDetail(tId);
  //     // assert
  //     verify(mockGetMovieRecommendations.execute(tId));
  //     expect(provider.movieRecommendations, tMovies);
  //   });

  //   test('should update recommendation state when data is gotten successfully',
  //       () async {
  //     // arrange
  //     _arrangeUsecase();
  //     // act
  //     await provider.fetchMovieDetail(tId);
  //     // assert
  //     expect(provider.recommendationState, RequestState.Loaded);
  //     expect(provider.movieRecommendations, tMovies);
  //   });

  //   test('should update error message when request in successful', () async {
  //     // arrange
  //     when(mockGetMovieDetail.execute(tId))
  //         .thenAnswer((_) async => Right(testMovieDetail));
  //     when(mockGetMovieRecommendations.execute(tId))
  //         .thenAnswer((_) async => Left(ServerFailure('Failed')));
  //     // act
  //     await provider.fetchMovieDetail(tId);
  //     // assert
  //     expect(provider.recommendationState, RequestState.Error);
  //     expect(provider.message, 'Failed');
  //   });
  // });

  // group('Watchlist', () {
  //   test('should get the watchlist status', () async {
  //     // arrange
  //     when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
  //     // act
  //     await provider.loadWatchlistStatus(1);
  //     // assert
  //     expect(provider.isAddedToWatchlist, true);
  //   });

  //   test('should execute save watchlist when function called', () async {
  //     // arrange
  //     when(mockSaveWatchlist.execute(testMovieDetail))
  //         .thenAnswer((_) async => Right('Success'));
  //     when(mockGetWatchlistStatus.execute(testMovieDetail.id))
  //         .thenAnswer((_) async => true);
  //     // act
  //     await provider.addWatchlist(testMovieDetail);
  //     // assert
  //     verify(mockSaveWatchlist.execute(testMovieDetail));
  //   });

  //   test('should execute remove watchlist when function called', () async {
  //     // arrange
  //     when(mockRemoveWatchlist.execute(testMovieDetail))
  //         .thenAnswer((_) async => Right('Removed'));
  //     when(mockGetWatchlistStatus.execute(testMovieDetail.id))
  //         .thenAnswer((_) async => false);
  //     // act
  //     await provider.removeFromWatchlist(testMovieDetail);
  //     // assert
  //     verify(mockRemoveWatchlist.execute(testMovieDetail));
  //   });

  //   test('should update watchlist status when add watchlist success', () async {
  //     // arrange
  //     when(mockSaveWatchlist.execute(testMovieDetail))
  //         .thenAnswer((_) async => Right('Added to Watchlist'));
  //     when(mockGetWatchlistStatus.execute(testMovieDetail.id))
  //         .thenAnswer((_) async => true);
  //     // act
  //     await provider.addWatchlist(testMovieDetail);
  //     // assert
  //     verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
  //     expect(provider.isAddedToWatchlist, true);
  //     expect(provider.watchlistMessage, 'Added to Watchlist');
  //     expect(listenerCallCount, 1);
  //   });

  //   test('should update watchlist message when add watchlist failed', () async {
  //     // arrange
  //     when(mockSaveWatchlist.execute(testMovieDetail))
  //         .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
  //     when(mockGetWatchlistStatus.execute(testMovieDetail.id))
  //         .thenAnswer((_) async => false);
  //     // act
  //     await provider.addWatchlist(testMovieDetail);
  //     // assert
  //     expect(provider.watchlistMessage, 'Failed');
  //     expect(listenerCallCount, 1);
  //   });
  // });

  // group('on Error', () {
  //   test('should return error when data is unsuccessful', () async {
  //     // arrange
  //     when(mockGetMovieDetail.execute(tId))
  //         .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
  //     when(mockGetMovieRecommendations.execute(tId))
  //         .thenAnswer((_) async => Right(tMovies));
  //     // act
  //     await provider.fetchMovieDetail(tId);
  //     // assert
  //     expect(provider.movieState, RequestState.Error);
  //     expect(provider.message, 'Server Failure');
  //     expect(listenerCallCount, 2);
  //   });
  // });
}
