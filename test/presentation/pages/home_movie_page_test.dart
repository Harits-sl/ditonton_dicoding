import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_page_test.mocks.dart';

@GenerateMocks([MovieListNotifier])
void main() {
  late MockMovieListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: Scaffold(body: body),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loading);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loading);
    when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display List when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockNotifier.nowPlayingMovies).thenReturn(<Movie>[]);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularMovies).thenReturn(<Movie>[]);
    when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedMovies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('page should have Widget CachedNetworkImage',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockNotifier.nowPlayingMovies).thenReturn([testMovie]);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularMovies).thenReturn([testMovie]);
    when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedMovies).thenReturn([testMovie]);

    final imageFinder = find.byType(CachedNetworkImage);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(imageFinder, findsWidgets);
  });
}
