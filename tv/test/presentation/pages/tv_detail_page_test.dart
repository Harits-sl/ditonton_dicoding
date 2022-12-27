import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_detail_cubit.dart';
import 'package:tv/presentation/bloc/tv_recommendation_cubit.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailCubit extends MockCubit<TvDetailState>
    implements TvDetailCubit {}

class MockTvDetailState extends Fake implements TvDetailState {}

class MockTvRecommendationCubit extends MockCubit<TvRecommendationState>
    implements TvRecommendationCubit {}

class MockTvRecommendationState extends Fake implements TvRecommendationState {}

class MockTvWatchlistBloc extends MockBloc<TvWatchlistEvent, TvWatchlistState>
    implements TvWatchlistBloc {}

class MockTvTvWatchlistEvent extends Fake implements TvWatchlistEvent {}

class MockTvTvWatchlistState extends Fake implements TvWatchlistState {}

void main() {
  late MockTvDetailCubit mockTvDetailCubit;
  late MockTvRecommendationCubit mockTvRecommendationCubit;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(MockTvDetailState());
    registerFallbackValue(MockTvRecommendationState());
    registerFallbackValue(MockTvTvWatchlistEvent());
    registerFallbackValue(MockTvTvWatchlistState());
  });

  setUp(() {
    mockTvDetailCubit = MockTvDetailCubit();
    mockTvRecommendationCubit = MockTvRecommendationCubit();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailCubit>(
          create: (_) => mockTvDetailCubit,
        ),
        BlocProvider<TvRecommendationCubit>(
          create: (_) => mockTvRecommendationCubit,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (_) => mockTvWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('watchlist', () {
    testWidgets(
        'Watchlist button should display add icon when tv not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockTvDetailCubit.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationCubit.state)
          .thenReturn(const TvRecommendationHasData(<Tv>[]));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(false));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when tv is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockTvDetailCubit.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationCubit.state)
          .thenReturn(const TvRecommendationHasData(<Tv>[]));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(true));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(() => mockTvDetailCubit.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationCubit.state)
          .thenReturn(const TvRecommendationHasData(<Tv>[]));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(false));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistMessage('Added to Watchlist'));

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (WidgetTester tester) async {
      when(() => mockTvDetailCubit.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationCubit.state)
          .thenReturn(const TvRecommendationHasData(<Tv>[]));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(false));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistError('Failed'));

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });
  });

  group('recommendation', () {
    testWidgets('should not display tv recommendation when state is empty',
        (WidgetTester tester) async {
      when(() => mockTvDetailCubit.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationCubit.state)
          .thenReturn(const TvRecommendationHasData(<Tv>[]));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(false));

      final keyEmpty = find.byKey(const Key('empty recommendation'));

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(keyEmpty, findsOneWidget);
    });
  });

  group('detail page', () {
    testWidgets('page should have Widget CachedNetworkImage',
        (WidgetTester tester) async {
      when(() => mockTvDetailCubit.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationCubit.state)
          .thenReturn(TvRecommendationHasData([testTv]));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(false));

      final imageFinder = find.byType(CachedNetworkImage);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(imageFinder, findsWidgets);
    });
    testWidgets('page should can tap back button', (WidgetTester tester) async {
      when(() => mockTvDetailCubit.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationCubit.state)
          .thenReturn(const TvRecommendationHasData(<Tv>[]));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(false));

      final buttonFinder = find.byKey(const Key('back_button'));

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
      await tester.tap(buttonFinder);

      expect(buttonFinder, findsOneWidget);
    });
  });
}
