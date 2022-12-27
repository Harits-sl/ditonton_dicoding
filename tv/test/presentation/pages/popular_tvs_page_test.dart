import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

class MockPopularTvsCubit extends MockCubit<PopularTvsState>
    implements PopularTvsCubit {}

class MockPopularTvsState extends Fake implements PopularTvsState {}

void main() {
  late MockPopularTvsCubit mockPopularTvsCubit;

  setUpAll(() {
    registerFallbackValue(MockPopularTvsState());
  });

  setUp(() {
    mockPopularTvsCubit = MockPopularTvsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvsCubit>.value(
      value: mockPopularTvsCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvsCubit.state).thenReturn(PopularTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvsCubit.state)
        .thenReturn(const PopularTvsHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvsCubit.state)
        .thenReturn(const PopularTvsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
