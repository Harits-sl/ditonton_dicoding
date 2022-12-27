import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
  });

  final testMovieTableId = testMovieTable.id;
  final testTVTableId = testTvTable.id;

  group('Movie test on db', () {
    test('should return movie id when inserting new movie', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result = await mockDatabaseHelper.insertWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return movie id when deleting a movie', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result = await mockDatabaseHelper.removeWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return Movie Detail Table when getting movie by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testMovieTableId))
          .thenAnswer((_) async => testMovieTable.toJson());
      // act
      final result = await mockDatabaseHelper.getMovieById(testMovieTableId);
      // assert
      expect(result, testMovieTable.toJson());
    });

    test('should return null when getting movie by id is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testMovieTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getMovieById(testMovieTableId);
      // assert
      expect(result, null);
    });

    test('should return list of movie map when getting watchlist movies',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistMovies();
      // assert
      expect(result, [testMovieMap]);
    });
  });

  group('TV Show test on db', () {
    test('should return tv show id when inserting new tv show', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => testTVTableId);
      // act
      final result = await mockDatabaseHelper.insertWatchlistTv(testTvTable);
      // assert
      expect(result, testTVTableId);
    });

    test('should return tv show id when deleting a tv show', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => testTVTableId);
      // act
      final result = await mockDatabaseHelper.removeWatchlistTv(testTvTable);
      // assert
      expect(result, testTVTableId);
    });

    test(
        'should return TV Show Detail Table when getting tv show by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvById(testTVTableId))
          .thenAnswer((_) async => testTvTable.toJson());
      // act
      final result = await mockDatabaseHelper.getTvById(testTVTableId);
      // assert
      expect(result, testTvTable.toJson());
    });

    test('should return null when getting tv show by id is not found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvById(testTVTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getTvById(testTVTableId);
      // assert
      expect(result, null);
    });

    test('should return list of tv show map when getting watchlist tv shows',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvs())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistTvs();
      // assert
      expect(result, [testTvMap]);
    });
  });
}
