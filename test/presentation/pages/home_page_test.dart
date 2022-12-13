import 'package:ditonton/common/body_state_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([HomeNotifier, MovieListNotifier, TvListNotifier])
void main() {
  late MockHomeNotifier mockHomeNotifier;
  late MockMovieListNotifier mockMovieListNotifier;
  late MockTvListNotifier mockTvListNotifier;

  setUp(() {
    mockHomeNotifier = MockHomeNotifier();
    mockMovieListNotifier = MockMovieListNotifier();
    mockTvListNotifier = MockTvListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeNotifier>(
          create: (context) => mockHomeNotifier,
        ),
        ChangeNotifierProvider<MovieListNotifier>(
          create: (context) => mockMovieListNotifier,
        ),
        ChangeNotifierProvider<MockTvListNotifier>(
          create: (context) => mockTvListNotifier,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('All required widget should display',
      (WidgetTester tester) async {
    when(mockHomeNotifier.bodyState).thenReturn(BodyState.Movie);
    when(mockMovieListNotifier.nowPlayingState)
        .thenReturn(RequestState.Loading);
    when(mockMovieListNotifier.popularMoviesState)
        .thenReturn(RequestState.Loading);
    when(mockMovieListNotifier.topRatedMoviesState)
        .thenReturn(RequestState.Loading);

    final scaffoldFinder = find.byType(Scaffold);
    final columnFinder = find.byType(Column);
    final appBarFinder = find.byType(AppBar);
    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    final ScaffoldState state = tester.firstState(scaffoldFinder);
    state.openDrawer();
    await tester.pump();

    expect(columnFinder, findsWidgets);
    expect(appBarFinder, findsOneWidget);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView movie when data is loaded',
      (WidgetTester tester) async {
    when(mockHomeNotifier.bodyState).thenReturn(BodyState.Movie);
    when(mockMovieListNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockMovieListNotifier.nowPlayingMovies).thenReturn(<Movie>[]);
    when(mockMovieListNotifier.popularMoviesState)
        .thenReturn(RequestState.Loaded);
    when(mockMovieListNotifier.popularMovies).thenReturn(<Movie>[]);
    when(mockMovieListNotifier.topRatedMoviesState)
        .thenReturn(RequestState.Loaded);
    when(mockMovieListNotifier.topRatedMovies).thenReturn(<Movie>[]);

    final textFinder = find.text('Popular');
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    expect(textFinder, findsOneWidget);
    expect(listViewFinder, findsWidgets);
  });
}
