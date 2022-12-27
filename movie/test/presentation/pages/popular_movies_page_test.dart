import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMoviesCubit extends MockCubit<PopularMoviesState>
    implements PopularMoviesCubit {}

class MockPopularMoviesState extends Fake implements PopularMoviesState {}

void main() {
  late MockPopularMoviesCubit mockPopularMoviesCubit;

  setUpAll(() {
    registerFallbackValue(MockPopularMoviesState());
  });

  setUp(() {
    mockPopularMoviesCubit = MockPopularMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesCubit>.value(
      value: mockPopularMoviesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesCubit.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesCubit.state)
        .thenReturn(const PopularMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesCubit.state)
        .thenReturn(const PopularMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('page should show MovieCard when Search Has Data',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesCubit.state)
        .thenReturn(PopularMoviesHasData([testMovie]));

    final movieCardFinder = find.byType(MovieCard);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(movieCardFinder, findsOneWidget);
  });

  testWidgets('page should can tap back button', (WidgetTester tester) async {
    when(() => mockPopularMoviesCubit.state)
        .thenReturn(const PopularMoviesHasData(<Movie>[]));

    final buttonFinder = find.byKey(const Key('back_button'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));
    await tester.tap(buttonFinder);

    expect(buttonFinder, findsOneWidget);
  });
}
