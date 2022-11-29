import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MockHttpClient mockhttpClient;
  late TvRemoteDataSourceImpl tvRemoteDataSource;

  setUp(() {
    mockhttpClient = MockHttpClient();
    tvRemoteDataSource = TvRemoteDataSourceImpl(client: mockhttpClient);
  });

  group('get now playing tvs', () {
    final tTvResponseModel = TvResponse.fromJson(
            jsonDecode(readJson('dummy_data/tv_now_playing.json')))
        .tvList;

    test('should return list of tvs model when the response code status is 200',
        () async {
      // arrange
      when(mockhttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_now_playing.json'), 200));
      // act
      final result = await tvRemoteDataSource.getNowPlayingTvs();
      // assert
      expect(result, equals(tTvResponseModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockhttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = tvRemoteDataSource.getNowPlayingTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular tvs', () {
    final tTvResponseModel =
        TvResponse.fromJson(jsonDecode(readJson('dummy_data/tv_popular.json')))
            .tvList;

    test('should return list of tvs model when the response code status is 200',
        () async {
      // arrange
      when(mockhttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_popular.json'), 200));
      // act
      final result = await tvRemoteDataSource.getPopularTvs();
      // assert
      expect(result, equals(tTvResponseModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockhttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = tvRemoteDataSource.getPopularTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated tvs', () {
    final tTvResponseModel = TvResponse.fromJson(
            jsonDecode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;

    test('should return list of tvs model when the response code status is 200',
        () async {
      // arrange
      when(mockhttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_top_rated.json'), 200));
      // act
      final result = await tvRemoteDataSource.getTopRatedTvs();
      // assert
      expect(result, equals(tTvResponseModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockhttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = tvRemoteDataSource.getTopRatedTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
