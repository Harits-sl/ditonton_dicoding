import 'package:core/data/models/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTableMap = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should be a map of tv table', () {
    // arrange
    final tMovieTable = TvTable(
      id: 1,
      name: 'name',
      posterPath: 'posterPath',
      overview: 'overview',
    );
    // act
    final result = tMovieTable.toJson();
    // assert
    expect(result, tMovieTableMap);
  });
}
