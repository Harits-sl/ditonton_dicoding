import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

import 'robots/about_robot.dart';
import 'robots/home_robot.dart';
import 'robots/now_playing_tvs_robot.dart';
import 'robots/popular_movies_robot.dart';
import 'robots/popular_tvs_robot.dart';
import 'robots/top_rated_movies_robot.dart';
import 'robots/top_rated_tvs_robot.dart';
import 'robots/watchlist_robot.dart';

void main() {
  group('Testing App', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('whole app', (WidgetTester tester) async {
      app.main();
      final homeRobot = HomeRobot(tester);
      final watchlistRobot = WatchlistRobot(tester);
      final aboutRobot = AboutRobot(tester);
      final popularMoviesRobot = PopularMoviesRobot(tester);
      final topRatedMoviesRobot = TopRatedMoviesRobot(tester);
      final nowPlayingTvsRobot = NowPlayingTvsRobot(tester);
      final popularTvsRobot = PopularTvsRobot(tester);
      final topRatedTvsRobot = TopRatedTvsRobot(tester);

      // test list movie in home page
      await homeRobot.findTitle();
      await homeRobot.findTextMovies();
      await homeRobot.addDelay(5000);
      await homeRobot.scrollListView(
        finderKey: 'now_playing_movies_5',
        listKey: 'now_playing_movies',
      );
      await homeRobot.addDelay(1000);
      await homeRobot.scrollListView(
        finderKey: 'popular_movies_5',
        listKey: 'popular_movies',
      );
      await homeRobot.addDelay(1000);
      await homeRobot.scrollListView(
        finderKey: 'top_rated_movies_5',
        listKey: 'top_rated_movies',
      );

      // test drawer
      await homeRobot.openDrawer();
      await homeRobot.clickButton('drawer_tvs');
      await homeRobot.addDelay(5000);
      await homeRobot.findTextTvs();
      await homeRobot.openDrawer();
      await homeRobot.clickButton('drawer_watchlist');
      await watchlistRobot.findTitle();
      await watchlistRobot.back();
      await homeRobot.openDrawer();
      await homeRobot.clickButton('drawer_about');
      await aboutRobot.findImage();
      await aboutRobot.findText();
      await aboutRobot.back();
      await homeRobot.openDrawer();
      await homeRobot.clickButton('drawer_movies');
      await homeRobot.findTextMovies();

      // test see more popular movie
      await homeRobot.clickButton('popular');
      await homeRobot.addDelay(5000);
      await popularMoviesRobot.scrollListView();
      await popularMoviesRobot.back();
      await homeRobot.findTitle();
      await homeRobot.findTextMovies();

      // test see more top rated movie
      await homeRobot.clickButton('top_rated');
      await homeRobot.addDelay(5000);
      await topRatedMoviesRobot.scrollListView();
      await topRatedMoviesRobot.back();
      await homeRobot.findTitle();
      await homeRobot.findTextMovies();

      // test to list tvs
      await homeRobot.openDrawer();
      await homeRobot.clickButton('drawer_tvs');
      await homeRobot.findTextTvs();
      await homeRobot.addDelay(5000);
      await homeRobot.scrollListView(
        finderKey: 'now_playing_tvs_5',
        listKey: 'now_playing_tvs',
      );
      await homeRobot.addDelay(1000);
      await homeRobot.scrollListView(
        finderKey: 'popular_tvs_5',
        listKey: 'popular_tvs',
      );
      await homeRobot.addDelay(1000);
      await homeRobot.scrollListView(
        finderKey: 'top_rated_tvs_5',
        listKey: 'top_rated_tvs',
      );
      await homeRobot.scrollToTop();

      // test see more now playing tvs
      await homeRobot.clickButton('now_playing');
      await homeRobot.addDelay(5000);
      await nowPlayingTvsRobot.scrollListView();
      await nowPlayingTvsRobot.back();
      await homeRobot.findTitle();
      await homeRobot.findTextTvs();

      // test see more popular tvs
      await homeRobot.clickButton('popular');
      await homeRobot.addDelay(5000);
      await popularTvsRobot.scrollListView();
      await popularTvsRobot.back();
      await homeRobot.findTitle();
      await homeRobot.findTextTvs();

      // test see more top rated tvs
      await homeRobot.clickButton('top_rated');
      await homeRobot.addDelay(5000);
      await topRatedTvsRobot.scrollListView();
      await topRatedTvsRobot.back();
      await homeRobot.findTitle();
      await homeRobot.findTextTvs();
    });
  });
}
