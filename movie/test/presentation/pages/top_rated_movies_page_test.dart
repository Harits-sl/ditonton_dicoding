import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedMoviesCubit extends MockCubit<TopRatedMoviesState>
    implements TopRatedMoviesCubit {}

class MockTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

void main() {
  late MockTopRatedMoviesCubit mockTopRatedMoviesCubit;

  setUpAll(() {
    registerFallbackValue(MockTopRatedMoviesState());
  });
  setUp(() {
    mockTopRatedMoviesCubit = MockTopRatedMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesCubit>.value(
      value: mockTopRatedMoviesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesCubit.state)
        .thenReturn(TopRatedMoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsWidgets);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesCubit.state)
        .thenReturn(const TopRatedMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesCubit.state)
        .thenReturn(const TopRatedMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('page should show MovieCard when Search Has Data',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesCubit.state)
        .thenReturn(TopRatedMoviesHasData([testMovie]));

    final movieCardFinder = find.byType(MovieCard);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(movieCardFinder, findsOneWidget);
  });

  testWidgets('page should can tap back button', (WidgetTester tester) async {
    when(() => mockTopRatedMoviesCubit.state)
        .thenReturn(const TopRatedMoviesHasData(<Movie>[]));

    final buttonFinder = find.byKey(const Key('back_button'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));
    await tester.tap(buttonFinder);

    expect(buttonFinder, findsOneWidget);
  });
}
