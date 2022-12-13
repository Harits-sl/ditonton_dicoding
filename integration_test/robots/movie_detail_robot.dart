import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';

class MovieDetailRobot {
  MovieDetailRobot(this.tester);

  final WidgetTester tester;

  Future<void> findImage() async {
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsAtLeastNWidgets(1));
  }

  Future<void> findRating() async {
    final ratingFinder = find.byType(RatingBarIndicator);
    expect(ratingFinder, findsOneWidget);
  }

  Future<void> findOverview() async {
    final textFinder = find.text('Overview');
    expect(textFinder, findsOneWidget);
  }

  Future<void> findRecommendation() async {
    final textFinder = find.text('Recommendations');
    expect(textFinder, findsOneWidget);
  }

  Future<void> scrollListView({
    required String finderKey,
    required String listKey,
    bool isScrollVertical = false,
  }) async {
    final scrollHorizontal = Offset(-500, 0.0);
    final scrollVertical = Offset(0.0, -500);
    final itemFinder = find.byKey(Key(finderKey));
    final listFinder = find.byKey(Key(listKey));
    if (isScrollVertical) {
      await tester.dragUntilVisible(
        itemFinder,
        listFinder,
        scrollVertical,
        duration: Duration(milliseconds: 500),
      );
    } else {
      await tester.dragUntilVisible(
        itemFinder,
        listFinder,
        scrollHorizontal,
        duration: Duration(milliseconds: 500),
      );
    }
    await tester.pumpAndSettle();
    expect(listFinder, findsOneWidget);
  }

  Future<void> clickButton(String buttonKey) async {
    final buttonFinder = find.byKey(Key(buttonKey));
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> scrollToTop() async {
    final scrollVertical = Offset(0.0, 500);
    final itemFinder = find.text('Watchlist');
    final listFinder = find.byKey(Key('scroll_view'));

    await tester.dragUntilVisible(
      itemFinder,
      listFinder,
      scrollVertical,
      duration: Duration(milliseconds: 500),
    );
    await tester.pumpAndSettle();
  }

  Future<void> findAddIcon() async {
    final iconFinder = find.byIcon(Icons.add);
    expect(iconFinder, findsOneWidget);
  }

  Future<void> findCheckIcon() async {
    final iconFinder = find.byIcon(Icons.check);
    expect(iconFinder, findsOneWidget);
  }

  Future<void> findSnackBarAdded() async {
    final snackBarFinder = find.byType(SnackBar);
    final textFinder = find.text('Added to Watchlist');
    expect(snackBarFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  }

  Future<void> findSnackBarRemoved() async {
    final snackBarFinder = find.byType(SnackBar);
    final textFinder = find.text('Removed from Watchlist');
    expect(snackBarFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  }

  Future<void> addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }

  Future<void> back() async {
    final backButtonFinder = find.byKey(Key('back_button'));
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();
  }
}
