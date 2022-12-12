import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

import 'robots/home_robot.dart';

void main() {
  group('Testing App', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('whole app', (WidgetTester tester) async {
      app.main();
      var homeRobot = HomeRobot(tester);

      await homeRobot.findTitle();
      await homeRobot.findTextMovies();
      await homeRobot.addDelay(5000);
      await homeRobot.scrollListView(
        'now_playing_movies_5',
        'now_playing_movies',
      );
      await homeRobot.addDelay(1000);

      await homeRobot.scrollListView(
        'popular_movies_5',
        'popular_movies',
      );
      await homeRobot.addDelay(1000);

      await homeRobot.scrollListView(
        'top_rated_movies_5',
        'top_rated_movies',
      );

      // await homeRobot.openDrawer();
      // await homeRobot.clickButton('drawer_tvs');
      // await homeRobot.addDelay(5000);
      // await homeRobot.findTextTvs();
    });
  });
}
