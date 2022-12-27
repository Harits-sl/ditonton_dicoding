import 'dart:convert';

import 'package:core/data/models/tv_model.dart';
import 'package:core/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    posterPath: '/posterPath.jpg',
    popularity: 1.0,
    id: 1,
    backdropPath: '/backdropPath.jpg',
    voteAverage: 1.0,
    overview: 'overview',
    firstAirDate: '2016-08-28',
    genreIds: [1, 2, 3],
    voteCount: 1,
    name: 'Victoria',
    originalName: 'Victoria',
  );
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(readJson('dummy_data/tv_now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange
      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/posterPath.jpg",
            "popularity": 1.0,
            "id": 1,
            "backdrop_path": "/backdropPath.jpg",
            "vote_average": 1.0,
            "overview": "overview",
            "first_air_date": "2016-08-28",
            "genre_ids": [1, 2, 3],
            "vote_count": 1,
            "name": "Victoria",
            "original_name": "Victoria",
          }
        ]
      };

      expect(result, expectedJsonMap);
    });
  });
}
