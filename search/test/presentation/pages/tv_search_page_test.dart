import 'package:bloc_test/bloc_test.dart';
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

  testWidgets('Page should not display anything when error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvError('error'));

    final keyFinder = find.byKey(Key('error'));

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(keyFinder, findsOneWidget);
  });
}
