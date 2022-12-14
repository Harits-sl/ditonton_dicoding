import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SearchRobot {
  SearchRobot(this.tester);

  final WidgetTester tester;

  Future<void> findTitle() async {
    final textFinder = find.text('Search');
    expect(textFinder, findsOneWidget);
  }

  Future<void> findTextField() async {
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);
  }

  Future<void> findText() async {
    final textFinder = find.text('Search Result');
    expect(textFinder, findsOneWidget);
  }

  Future<void> insertText() async {
    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, 'spiderman');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> findItemSearch() async {
    final typeFinder = find.byType(MovieCard);
    expect(typeFinder, findsAtLeastNWidgets(1));
  }

  Future<void> clickButton(String buttonKey) async {
    final buttonFinder = find.byKey(Key(buttonKey));
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
    await tester.pumpAndSettle();
  }

  Future<void> back() async {
    final backButtonFinder = find.byKey(Key('back_button'));
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();
  }
}
