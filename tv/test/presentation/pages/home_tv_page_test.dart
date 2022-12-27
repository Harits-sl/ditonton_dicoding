import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingTvsCubit extends MockCubit<NowPlayingTvsState>
    implements NowPlayingTvsCubit {}

class MockNowPlayingTvsState extends Fake implements NowPlayingTvsState {}

class MockPopularTvsCubit extends MockCubit<PopularTvsState>
    implements PopularTvsCubit {}

class MockPopularTvsState extends Fake implements PopularTvsState {}

class MockTopRatedTvsCubit extends MockCubit<TopRatedTvsState>
    implements TopRatedTvsCubit {}

class MockTopRatedTvsState extends Fake implements TopRatedTvsState {}

void main() {
  late MockNowPlayingTvsCubit mockNowPlayingTvsCubit;
  late MockPopularTvsCubit mockPopularTvsCubit;
  late MockTopRatedTvsCubit mockTopRatedTvsCubit;

  setUpAll(() {
    registerFallbackValue(MockNowPlayingTvsState());
    registerFallbackValue(MockPopularTvsState());
    registerFallbackValue(MockTopRatedTvsState());
  });

  setUp(() {
    mockNowPlayingTvsCubit = MockNowPlayingTvsCubit();
    mockPopularTvsCubit = MockPopularTvsCubit();
    mockTopRatedTvsCubit = MockTopRatedTvsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvsCubit>(
          create: (_) => mockNowPlayingTvsCubit,
        ),
        BlocProvider<PopularTvsCubit>(
          create: (_) => mockPopularTvsCubit,
        ),
        BlocProvider<TopRatedTvsCubit>(
          create: (_) => mockTopRatedTvsCubit,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(body: body),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvsCubit.state).thenReturn(NowPlayingTvsLoading());
    when(() => mockPopularTvsCubit.state).thenReturn(PopularTvsLoading());
    when(() => mockTopRatedTvsCubit.state).thenReturn(TopRatedTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvPage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display List when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvsCubit.state)
        .thenReturn(const NowPlayingTvsHasData(<Tv>[]));
    when(() => mockPopularTvsCubit.state)
        .thenReturn(const PopularTvsHasData(<Tv>[]));
    when(() => mockTopRatedTvsCubit.state)
        .thenReturn(const TopRatedTvsHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('page should have Widget CachedNetworkImage',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvsCubit.state)
        .thenReturn(NowPlayingTvsHasData([testTv]));
    when(() => mockPopularTvsCubit.state)
        .thenReturn(PopularTvsHasData([testTv]));
    when(() => mockTopRatedTvsCubit.state)
        .thenReturn(TopRatedTvsHasData([testTv]));

    final imageFinder = find.byType(CachedNetworkImage);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvPage()));

    expect(imageFinder, findsWidgets);
  });
}
