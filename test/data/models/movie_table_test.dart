import 'package:ditonton/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTableMap = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview'
  };

  test('should be a map of movie table', () {
    // arrange
    final tMovieTable = MovieTable(
      id: 1,
      title: 'title',
      posterPath: 'posterPath',
      overview: 'overview',
    );
    // act
    final result = tMovieTable.toJson();
    // assert
    expect(result, tMovieTableMap);
  });
}
