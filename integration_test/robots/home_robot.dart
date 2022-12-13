import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeRobot {
  const HomeRobot(this.tester);

  final WidgetTester tester;

  Future<void> findTitle() async {
    await tester.pumpAndSettle();
    final textFinder = find.text('Ditonton');
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

  Future<void> addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }

  Future<void> openDrawer() async {
    final scaffoldFinder = find.byType(Scaffold);
    final ScaffoldState state = tester.firstState(scaffoldFinder);
    state.openDrawer();
    await tester.pumpAndSettle();
  }

  Future<void> clickButton(String buttonKey) async {
    final buttonFinder = find.byKey(Key(buttonKey));
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> findTextMovies() async {
    final nowPlayingFinder = find.text('Now Playing');
    final popularFinder = find.text('Popular');
    final topRatedFinder = find.text('Top Rated');

    expect(nowPlayingFinder, findsOneWidget);
    expect(popularFinder, findsOneWidget);
    expect(topRatedFinder, findsOneWidget);

    await tester.pump();
  }

  Future<void> findTextTvs() async {
    final nowPlayingFinder = find.text('Now Playing Tvs');
    final popularFinder = find.text('Popular Tvs');
    final topRatedFinder = find.text('Top Rated Tvs');

    expect(nowPlayingFinder, findsOneWidget);
    expect(popularFinder, findsOneWidget);
    expect(topRatedFinder, findsOneWidget);

    await tester.pump();
  }

  Future<void> findSearch() async {
    final iconFinder = find.byIcon(Icons.search);
    expect(iconFinder, findsOneWidget);
  }

  Future<void> scrollToTop() async {
    final scrollVertical = Offset(0.0, 500);
    final itemFinder = find.byKey(Key('now_playing'));
    final listFinder = find.byKey(Key('scroll_tv'));

    await tester.dragUntilVisible(
      itemFinder,
      listFinder,
      scrollVertical,
      duration: Duration(milliseconds: 500),
    );
    await tester.pumpAndSettle();
  }
}
