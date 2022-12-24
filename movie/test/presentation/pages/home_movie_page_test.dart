import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingMoviesCubit extends MockCubit<NowPlayingMoviesState>
    implements NowPlayingMoviesCubit {}

class MockNowPlayingMoviesState extends Fake implements NowPlayingMoviesState {}

class MockPopularMoviesCubit extends MockCubit<PopularMoviesState>
    implements PopularMoviesCubit {}

class MockPopularMoviesState extends Fake implements PopularMoviesState {}

class MockTopRatedMoviesCubit extends MockCubit<TopRatedMoviesState>
    implements TopRatedMoviesCubit {}

class MockTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

void main() {
  late MockNowPlayingMoviesCubit mockNowPlayingMoviesCubit;
  late MockPopularMoviesCubit mockPopularMoviesCubit;
  late MockTopRatedMoviesCubit mockTopRatedMoviesCubit;

  setUpAll(() {
    registerFallbackValue(MockNowPlayingMoviesState());
    registerFallbackValue(MockPopularMoviesState());
    registerFallbackValue(MockTopRatedMoviesState());
  });

  setUp(() {
    mockNowPlayingMoviesCubit = MockNowPlayingMoviesCubit();
    mockPopularMoviesCubit = MockPopularMoviesCubit();
    mockTopRatedMoviesCubit = MockTopRatedMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesCubit>(
          create: (_) => mockNowPlayingMoviesCubit,
        ),
        BlocProvider<PopularMoviesCubit>(
          create: (_) => mockPopularMoviesCubit,
        ),
        BlocProvider<TopRatedMoviesCubit>(
          create: (_) => mockTopRatedMoviesCubit,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(body: body),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMoviesCubit.state)
        .thenReturn(NowPlayingMoviesLoading());
    when(() => mockPopularMoviesCubit.state).thenReturn(PopularMoviesLoading());
    when(() => mockTopRatedMoviesCubit.state)
        .thenReturn(TopRatedMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display List when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMoviesCubit.state)
        .thenReturn(const NowPlayingMoviesHasData(<Movie>[]));
    when(() => mockPopularMoviesCubit.state)
        .thenReturn(const PopularMoviesHasData(<Movie>[]));
    when(() => mockTopRatedMoviesCubit.state)
        .thenReturn(const TopRatedMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('page should have Widget CachedNetworkImage',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMoviesCubit.state)
        .thenReturn(NowPlayingMoviesHasData([testMovie]));
    when(() => mockPopularMoviesCubit.state)
        .thenReturn(PopularMoviesHasData([testMovie]));
    when(() => mockTopRatedMoviesCubit.state)
        .thenReturn(TopRatedMoviesHasData([testMovie]));

    final imageFinder = find.byType(CachedNetworkImage);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(imageFinder, findsWidgets);
  });
}
