import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieCubit watchlistMovieCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieCubit = WatchlistMovieCubit(mockGetWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(watchlistMovieCubit.state, WatchlistMovieInitial());
  });

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistMovieCubit;
    },
    act: (cubit) => cubit.fetchWatchlistMovies(),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieHasData([testWatchlistMovie]),
    ],
    verify: (cubit) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistMovieCubit;
    },
    act: (cubit) => cubit.fetchWatchlistMovies(),
    expect: () => [
      WatchlistMovieLoading(),
      const WatchlistMovieError("Can't get data"),
    ],
    verify: (cubit) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
