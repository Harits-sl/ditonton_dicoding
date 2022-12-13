import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieNotifier, WatchlistTvNotifier])
void main() {
  late MockWatchlistMovieNotifier mockMovieNotifier;
  late MockWatchlistTvNotifier mockTvNotifier;

  setUp(() {
    mockMovieNotifier = MockWatchlistMovieNotifier();
    mockTvNotifier = MockWatchlistTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WatchlistMovieNotifier>(
          create: (context) => mockMovieNotifier,
        ),
        ChangeNotifierProvider<WatchlistTvNotifier>(
          create: (context) => mockTvNotifier,
        )
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Loading);
    when(mockMovieNotifier.watchlistMovies).thenReturn(<Movie>[]);
    when(mockTvNotifier.watchlistState).thenReturn(RequestState.Loading);
    when(mockTvNotifier.watchlistTvs).thenReturn(<Tv>[]);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.watchlistMovies).thenReturn(<Movie>[]);
    when(mockTvNotifier.watchlistState).thenReturn(RequestState.Loaded);
    when(mockTvNotifier.watchlistTvs).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Error);
    when(mockMovieNotifier.message).thenReturn('Error message');
    when(mockMovieNotifier.watchlistMovies).thenReturn(<Movie>[]);
    when(mockTvNotifier.watchlistState).thenReturn(RequestState.Error);
    when(mockTvNotifier.message).thenReturn('Error message');
    when(mockTvNotifier.watchlistTvs).thenReturn(<Tv>[]);

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(textFinder, findsOneWidget);
  });
}
