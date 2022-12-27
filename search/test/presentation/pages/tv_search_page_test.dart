import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchBlocTv extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}

class MockSearchTvEvent extends Fake implements SearchTvEvent {}

class MockSearchTvState extends Fake implements SearchTvState {}

void main() {
  late MockSearchBlocTv mockBloc;

  setUpAll(() {
    registerFallbackValue(MockSearchTvEvent());
    registerFallbackValue(MockSearchTvState());
  });

  setUp(() {
    mockBloc = MockSearchBlocTv();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final testTv = Tv(
    posterPath: '/jeGtaMwGxPmQN5xM4ClnwPQcNQz.jpg',
    popularity: 1397.308,
    id: 119051,
    backdropPath: '/9DpB6wC1iY5jxLz91RT8tIIsXaf.jpg',
    voteAverage: 8.8,
    overview:
        "Wednesday Addams is sent to Nevermore Academy, a bizarre boarding school where she attempts to master her psychic powers, stop a monstrous killing spree of the town citizens, and solve the supernatural mystery that affected her family 25 years ago - all while navigating her new relationships.",
    firstAirDate: '2022-11-23',
    genreIds: [10765, 9648, 35],
    voteCount: 686,
    name: 'Wednesdayy',
    originalName: 'Wednesdayy',
  );

  final testTvList = [testTv];

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvLoading());

    final progressBarFinder = find.byKey(Key('loading'));

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('text field should change when input text',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvHasData(<Tv>[]));

    final textFieldFinder = find.byType(TextField);
    final textFinder = find.text('one piece');

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));
    await tester.enterText(textFieldFinder, 'one piece');

    expect(textFieldFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('page should show TvCard when Search Has Data',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvHasData(testTvList));

    final tvCardFinder = find.byType(TvCard);

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(tvCardFinder, findsOneWidget);
  });

  testWidgets('page should can tap back button', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvHasData(<Tv>[]));

    final buttonFinder = find.byKey(Key('back_button'));

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));
    await tester.tap(buttonFinder);

    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('Page should not display anything when error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvError('error'));

    final keyFinder = find.byKey(Key('error'));

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(keyFinder, findsOneWidget);
  });

  testWidgets('Page should not display anything when state is empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvEmpty());

    final keyFinder = find.byKey(Key('empty'));

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(keyFinder, findsOneWidget);
  });
}
