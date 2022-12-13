import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

class AboutRobot {
  AboutRobot(this.tester);

  final WidgetTester tester;

  Future<void> findImage() async {
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  }

  Future<void> findText() async {
    final textFinder = find.byType(Text);
    expect(textFinder, findsOneWidget);
  }

  Future<void> back() async {
    final backButtonFinder = find.byKey(Key('back_button'));
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();
  }
}
