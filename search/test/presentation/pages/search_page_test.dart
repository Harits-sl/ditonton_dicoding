import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/movie/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/pages/search_page.dart';

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

  final testMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieList = [testMovie];

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

  testWidgets('text field should change when input text',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchHasData(<Movie>[]));

    final textFieldFinder = find.byType(TextField);
    final textFinder = find.text('spiderman');

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));
    await tester.enterText(textFieldFinder, 'spiderman');

    expect(textFieldFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('page should show MovieCard when Search Has Data',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchHasData(testMovieList));

    final movieCardFinder = find.byType(MovieCard);

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(movieCardFinder, findsOneWidget);
  });

  testWidgets('page should can tap back button', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchHasData(<Movie>[]));

    final buttonFinder = find.byKey(Key('back_button'));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));
    await tester.tap(buttonFinder);

    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('Page should not display anything when error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchError('error'));

    final keyFinder = find.byKey(Key('error'));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(keyFinder, findsOneWidget);
  });

  testWidgets('Page should not display anything when state is empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchEmpty());

    final keyFinder = find.byKey(Key('empty'));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(keyFinder, findsOneWidget);
  });
}
