import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/movie/search_bloc.dart';
import '../../../../search/lib/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchBlocMovie extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class MockSearchEvent extends Fake implements SearchEvent {}

class MockSearchState extends Fake implements SearchState {}

void main() {
  late MockSearchBlocMovie mockBloc;

  setUpAll(() {
    registerFallbackValue(MockSearchEvent());
    registerFallbackValue(MockSearchState());
  });

  setUp(() {
    mockBloc = MockSearchBlocMovie();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchLoading());
    debugPrint('mockBloc.state: ${mockBloc.state}');

    // final progressBarFinder = find.byType(CircularProgressIndicator);
    final progressBarFinder = find.byKey(Key('loading'));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should not display anything when error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchError('error'));

    final keyFinder = find.byKey(Key('error'));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(keyFinder, findsOneWidget);
  });
}
