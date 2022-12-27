import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

class MockNowPlayingTvsCubit extends MockCubit<NowPlayingTvsState>
    implements NowPlayingTvsCubit {}

class MockNowPlayingTvsState extends Fake implements NowPlayingTvsState {}

void main() {
  late MockNowPlayingTvsCubit mockNowPlayingTvsCubit;

  setUpAll(() {
    registerFallbackValue(MockNowPlayingTvsState());
  });

  setUp(() {
    mockNowPlayingTvsCubit = MockNowPlayingTvsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvsCubit>.value(
      value: mockNowPlayingTvsCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvsCubit.state).thenReturn(NowPlayingTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvsPage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvsCubit.state)
        .thenReturn(const NowPlayingTvsHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvsCubit.state)
        .thenReturn(const NowPlayingTvsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
