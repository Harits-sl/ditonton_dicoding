import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistMovieCubit extends MockCubit<WatchlistMovieState>
    implements WatchlistMovieCubit {}

class MockWatchlistMovieState extends Fake implements WatchlistMovieState {}

class MockWatchlistTvCubit extends MockCubit<WatchlistTvState>
    implements WatchlistTvCubit {}

class MockWatchlistTvState extends Fake implements WatchlistTvState {}

void main() {
  late MockWatchlistMovieCubit mockWatchlistMovieCubit;
  late MockWatchlistTvCubit mockWatchlistTvCubit;

  setUpAll(() {
    registerFallbackValue(MockWatchlistMovieState());
    registerFallbackValue(MockWatchlistTvState());
  });

  setUp(() {
    mockWatchlistMovieCubit = MockWatchlistMovieCubit();
    mockWatchlistTvCubit = MockWatchlistTvCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMovieCubit>(
          create: (_) => mockWatchlistMovieCubit,
        ),
        BlocProvider<WatchlistTvCubit>(
          create: (_) => mockWatchlistTvCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieCubit.state)
        .thenReturn(WatchlistMovieLoading());
    when(() => mockWatchlistTvCubit.state).thenReturn(WatchlistTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieCubit.state)
        .thenReturn(WatchlistMovieHasData(<Movie>[]));
    when(() => mockWatchlistTvCubit.state)
        .thenReturn(WatchlistTvHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieCubit.state)
        .thenReturn(WatchlistMovieError('Error message'));
    when(() => mockWatchlistTvCubit.state)
        .thenReturn(WatchlistTvError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(textFinder, findsOneWidget);
  });
}
