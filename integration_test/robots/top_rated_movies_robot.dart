import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TopRatedMoviesRobot {
  TopRatedMoviesRobot(this.tester);

  final WidgetTester tester;

  Future<void> scrollListView() async {
    final scrollVertical = Offset(0.0, -500);
    final itemFinder = find.byKey(Key('top_rated_5'));
    final listFinder = find.byKey(Key('list_top_rated'));
    await tester.dragUntilVisible(
      itemFinder,
      listFinder,
      scrollVertical,
      duration: Duration(milliseconds: 500),
    );
    await tester.pumpAndSettle();
    expect(listFinder, findsOneWidget);
  }

  Future<void> back() async {
    final backButtonFinder = find.byKey(Key('back_button'));
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();
  }
}
