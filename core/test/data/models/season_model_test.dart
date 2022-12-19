import 'package:core/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testSeasonMap = {
    'air_date': 'airDate',
    'episode_count': 10,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 10
  };

  test('should be a map of genre', () {
    // arrange
    final testGenreModel = SeasonModel(
      airDate: 'airDate',
      episodeCount: 10,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 10,
    );
    // act
    final result = testGenreModel.toJson();
    // assert
    expect(result, testSeasonMap);
  });
}
