import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

class MockTopRatedTvsCubit extends MockCubit<TopRatedTvsState>
    implements TopRatedTvsCubit {}

class MockTopRatedTvsState extends Fake implements TopRatedTvsState {}

void main() {
  late MockTopRatedTvsCubit mockTopRatedTvsCubit;

  setUpAll(() {
    registerFallbackValue(MockTopRatedTvsState());
  });
  setUp(() {
    mockTopRatedTvsCubit = MockTopRatedTvsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvsCubit>.value(
      value: mockTopRatedTvsCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvsCubit.state).thenReturn(TopRatedTvsLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));

    expect(centerFinder, findsWidgets);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvsCubit.state)
        .thenReturn(const TopRatedTvsHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvsCubit.state)
        .thenReturn(const TopRatedTvsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
