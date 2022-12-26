import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'movie_recommendation_cubit_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationCubit movieRecommendationCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationCubit =
        MovieRecommendationCubit(mockGetMovieRecommendations);
  });

  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(movieRecommendationCubit.state, MovieRecommendationInitial());
  });

  blocTest<MovieRecommendationCubit, MovieRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));
      return movieRecommendationCubit;
    },
    act: (cubit) => cubit.fetchMovieRecommendation(tId),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationHasData(tMovies),
    ],
    verify: (cubit) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieRecommendationCubit, MovieRecommendationState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecommendationCubit;
    },
    act: (cubit) => cubit.fetchMovieRecommendation(tId),
    expect: () => [
      MovieRecommendationLoading(),
      const MovieRecommendationError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}
