import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvResponseImpl repository;
  late MockTvRemoteDataSource mockTvRemoteDataSource;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    repository = TvResponseImpl(remoteDataSource: mockTvRemoteDataSource);
  });

  final tTvModel = TvModel(
    posterPath: '/cvhNj9eoRBe5SxjCbQTkh05UP5K.jpg',
    popularity: 1377.974,
    id: 60625,
    backdropPath: '/uGy4DCmM33I7l86W7iCskNkvmLD.jpg',
    voteAverage: 8.7,
    overview:
        "Rick is a mentally-unbalanced but scientifically gifted old man who has recently reconnected with his family. He spends most of his time involving his young grandson Morty in dangerous, outlandish adventures throughout space and alternate universes. Compounded with Morty's already unstable family life, these events cause Morty much distress at home and school.",
    firstAirDate: '2022-09-26',
    genreIds: [16, 35, 10765, 10759],
    voteCount: 7426,
    name: 'Rick and Morty',
    originalName: 'Rick and Morty',
  );

  final tTv = Tv(
    posterPath: '/cvhNj9eoRBe5SxjCbQTkh05UP5K.jpg',
    popularity: 1377.974,
    id: 60625,
    backdropPath: '/uGy4DCmM33I7l86W7iCskNkvmLD.jpg',
    voteAverage: 8.7,
    overview:
        "Rick is a mentally-unbalanced but scientifically gifted old man who has recently reconnected with his family. He spends most of his time involving his young grandson Morty in dangerous, outlandish adventures throughout space and alternate universes. Compounded with Morty's already unstable family life, these events cause Morty much distress at home and school.",
    firstAirDate: '2022-09-26',
    genreIds: [16, 35, 10765, 10759],
    voteCount: 7426,
    name: 'Rick and Morty',
    originalName: 'Rick and Morty',
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('get now playing tvs', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTvs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTvs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTvs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTvs());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTvs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTvs());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get popular tvs', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTvs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTvs();
      // assert
      verify(mockTvRemoteDataSource.getPopularTvs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTvs()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvs();
      // assert
      verify(mockTvRemoteDataSource.getPopularTvs());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTvs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvs();
      // assert
      verify(mockTvRemoteDataSource.getPopularTvs());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get top rated tvs', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTvs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTvs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTvs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTvs());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTvs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTvs());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
