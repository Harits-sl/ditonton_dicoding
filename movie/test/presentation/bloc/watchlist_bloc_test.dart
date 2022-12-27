import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist, GetWatchListStatus])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    watchlistBloc = WatchlistBloc(
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      getWatchListStatus: mockGetWatchListStatus,
    );
  });

  const tId = 1;

  // final tMovie = Movie(
  //   adult: false,
  //   backdropPath: 'backdropPath',
  //   genreIds: const [1, 2, 3],
  //   id: 1,
  //   originalTitle: 'originalTitle',
  //   overview: 'overview',
  //   popularity: 1,
  //   posterPath: 'posterPath',
  //   releaseDate: 'releaseDate',
  //   title: 'title',
  //   video: false,
  //   voteAverage: 1,
  //   voteCount: 1,
  // );
  // final tMovies = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistInitial());
  });

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [WatchlistStatus] when LoadWatchlistStatus called',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
    expect: () => [
      const WatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Status, Message] when OnButtonAddWatchlistTapped called',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchlistBloc;
    },
    act: (bloc) {
      bloc.add(const LoadWatchlistStatus(tId));
      bloc.add(OnButtonAddWatchlistTapped(testMovieDetail));
    },
    expect: () => [
      const WatchlistStatus(true),
      const WatchlistMessage('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Status, Message] when OnButtonRemoveWatchlistTapped called',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => false);
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return watchlistBloc;
    },
    act: (bloc) {
      bloc.add(const LoadWatchlistStatus(tId));
      bloc.add(OnButtonRemoveWatchlistTapped(testMovieDetail));
    },
    expect: () => [
      const WatchlistStatus(false),
      const WatchlistMessage('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Error] when OnButtonAddWatchlistTapped failure',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistBloc;
    },
    act: (bloc) {
      bloc.add(OnButtonAddWatchlistTapped(testMovieDetail));
    },
    expect: () => [
      const WatchlistError('Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Error] when OnButtonRemoveWatchlistTapped failure',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistBloc;
    },
    act: (bloc) {
      bloc.add(OnButtonRemoveWatchlistTapped(testMovieDetail));
    },
    expect: () => [
      const WatchlistError('Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
