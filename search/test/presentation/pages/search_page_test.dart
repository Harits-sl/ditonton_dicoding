// import 'package:core/utils/state_enum.dart';
// import 'package:core/domain/entities/movie.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:search/presentation/bloc/search_bloc.dart';
// import '../../../../search/lib/presentation/pages/search_page.dart';
// import '../../../../search/lib/presentation/provider/movie_search_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import 'search_page_test.mocks.dart';

// @GenerateMocks([SearchBloc])
// void main() {
//   late MockSearchBloc mockBloc;

//   setUp(() {
//     mockBloc = MockSearchBloc();
//   });

//   Widget _makeTestableWidget(Widget body) {
//     return BlocProvider<SearchBloc>.value(
//       value: mockBloc,
//       child: MaterialApp(
//         home: body,
//       ),
//     );
//   }

//   testWidgets('Page should display center progress bar when loading',
//       (WidgetTester tester) async {
//     when(mockBloc.state).thenReturn(SearchLoading());

//     final progressBarFinder = find.byType(CircularProgressIndicator);

//     await tester.pumpWidget(_makeTestableWidget(SearchPage()));

//     expect(progressBarFinder, findsOneWidget);
//   });

//   testWidgets('Page should display ListView when data is loaded',
//       (WidgetTester tester) async {
//     when(mockBloc.state).thenReturn(SearchLoading());
//     when(mockBloc.searchResult).thenReturn(<Movie>[]);

//     final listViewFinder = find.byType(ListView);

//     await tester.pumpWidget(_makeTestableWidget(SearchPage()));

//     expect(listViewFinder, findsOneWidget);
//   });

//   testWidgets('Page should not display anything when error',
//       (WidgetTester tester) async {
//     when(mockBloc.state).thenReturn(RequestState.Error);

//     final keyFinder = find.byKey(Key('error'));

//     await tester.pumpWidget(_makeTestableWidget(SearchPage()));

//     expect(keyFinder, findsOneWidget);
//   });
// }
