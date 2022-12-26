import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailCubit extends MockCubit<MovieDetailState>
    implements MovieDetailCubit {}

class MockMovieDetailState extends Fake implements MovieDetailState {}

class MockMovieRecommendationCubit extends MockCubit<MovieRecommendationState>
    implements MovieRecommendationCubit {}

class MockMovieRecommendationState extends Fake
    implements MovieRecommendationState {}

class MockWatchlistBloc extends MockBloc<WatchlistEvent, WatchlistState>
    implements WatchlistBloc {}

class MockWatchlistEvent extends Fake implements WatchlistEvent {}

class MockWatchlistState extends Fake implements WatchlistState {}

void main() {
  late MockMovieDetailCubit mockMovieDetailCubit;
  late MockMovieRecommendationCubit mockMovieRecommendationCubit;
  late MockWatchlistBloc mockWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(MockMovieDetailState());
    registerFallbackValue(MockMovieRecommendationState());
    registerFallbackValue(MockWatchlistEvent());
    registerFallbackValue(MockWatchlistState());
  });

  setUp(() {
    mockMovieDetailCubit = MockMovieDetailCubit();
    mockMovieRecommendationCubit = MockMovieRecommendationCubit();
    mockWatchlistBloc = MockWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailCubit>(
          create: (_) => mockMovieDetailCubit,
        ),
        BlocProvider<MovieRecommendationCubit>(
          create: (_) => mockMovieRecommendationCubit,
        ),
        BlocProvider<WatchlistBloc>(
          create: (_) => mockWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('watchlist', () {
    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailCubit.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationCubit.state)
          .thenReturn(const MovieRecommendationHasData(<Movie>[]));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistStatus(false));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailCubit.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationCubit.state)
          .thenReturn(const MovieRecommendationHasData(<Movie>[]));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistStatus(true));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailCubit.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationCubit.state)
          .thenReturn(const MovieRecommendationHasData(<Movie>[]));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistStatus(false));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistMessage('Added to Watchlist'));

      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (WidgetTester tester) async {
      when(() => mockMovieDetailCubit.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationCubit.state)
          .thenReturn(const MovieRecommendationHasData(<Movie>[]));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistStatus(false));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistError('Failed'));

      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });
  });

  group('recommendation', () {
    testWidgets('should not display movie recommendation when state is empty',
        (WidgetTester tester) async {
      when(() => mockMovieDetailCubit.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationCubit.state)
          .thenReturn(const MovieRecommendationHasData(<Movie>[]));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistStatus(false));

      final keyEmpty = find.byKey(const Key('empty recommendation'));

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(keyEmpty, findsOneWidget);
    });
  });
}
