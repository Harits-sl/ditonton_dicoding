import 'package:ditonton/common/formatted_utils.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenres = [Genre(id: 1, name: 'Action')];
  group('showGenres', () {
    test('should get string genre ', () {
      // arrange

      // act
      final result = showGenres(tGenres);
      // assert
      final expected = 'Action';
      expect(result, expected);
    });
  });

  group('showDuration', () {
    test('should get string duration hours and minutes', () {
      // arrange

      // act
      final result = showDuration(65);
      // assert
      final expected = '1h 5m';
      expect(result, expected);
    });
    test('should get string duration minutes', () {
      // arrange

      // act
      final result = showDuration(45);
      // assert
      final expected = '45m';
      expect(result, expected);
    });
  });
}
