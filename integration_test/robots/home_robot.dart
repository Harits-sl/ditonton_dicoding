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

  Future<void> scrollListView(String finderKey, String listKey) async {
    final itemFinder = find.byKey(Key(finderKey));
    final listFinder = find.byKey(Key(listKey));
    await tester.dragUntilVisible(
      itemFinder,
      listFinder,
      const Offset(-500, 0.0),
      duration: Duration(milliseconds: 500),
    );
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
}
