import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

class WatchlistRobot {
  WatchlistRobot(this.tester);

  final WidgetTester tester;

  Future<void> findTitle() async {
    final textFinder = find.text('Watchlist');
    expect(textFinder, findsOneWidget);
  }

  Future<void> back() async {
    final backButtonFinder = find.byKey(Key('back_button'));
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();
  }
}
