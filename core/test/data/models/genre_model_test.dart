import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testGenreMap = {'id': 1, 'name': 'Action'};

  test('should be a map of genre', () {
    // arrange
    final testGenreModel = GenreModel(id: 1, name: 'Action');
    // act
    final result = testGenreModel.toJson();
    // assert
    expect(result, testGenreMap);
  });
}
