import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

import 'robots/about_robot.dart';
import 'robots/home_robot.dart';
import 'robots/movie_detail_robot.dart';
import 'robots/now_playing_tvs_robot.dart';
import 'robots/popular_movies_robot.dart';
import 'robots/popular_tvs_robot.dart';
import 'robots/search_robot.dart';
import 'robots/top_rated_movies_robot.dart';
import 'robots/top_rated_tvs_robot.dart';
import 'robots/tv_detail_robot.dart';
import 'robots/tv_search_robot.dart';
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
      final movieDetailRobot = MovieDetailRobot(tester);
      final tvDetailRobot = TvDetailRobot(tester);
      final tvSearchRobot = TvSearchRobot(tester);
      final searchRobot = SearchRobot(tester);

      // test list movie in home page
      await homeRobot.findTitle();
      await homeRobot.findTextMovies();
      await homeRobot.addDelay(5000);
      await homeRobot.scrollListView(
        finderKey: 'now_playing_movie_5',
        listKey: 'now_playing_movie',
      );
      await homeRobot.addDelay(1000);
      await homeRobot.scrollListView(
        finderKey: 'popular_movie_5',
        listKey: 'popular_movie',
      );
      await homeRobot.addDelay(1000);
      await homeRobot.scrollListView(
        finderKey: 'top_rated_movie_0',
        listKey: 'scroll_view',
        isScrollVertical: true,
      );
      await homeRobot.scrollListView(
        finderKey: 'top_rated_movie_5',
        listKey: 'top_rated_movie',
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
      await homeRobot.scrollListView(
        finderKey: 'top_rated_movie_0',
        listKey: 'scroll_view',
        isScrollVertical: true,
      );
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
        finderKey: 'now_playing_tv_5',
        listKey: 'now_playing_tv',
      );
      await homeRobot.addDelay(1000);
      await homeRobot.scrollListView(
        finderKey: 'popular_tv_5',
        listKey: 'popular_tv',
      );
      await homeRobot.addDelay(1000);
      await homeRobot.scrollListView(
        finderKey: 'top_rated_tv_5',
        listKey: 'top_rated_tv',
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
      await homeRobot.scrollListView(
        finderKey: 'top_rated_tv_5',
        listKey: 'scroll_tv',
        isScrollVertical: true,
      );
      await homeRobot.clickButton('top_rated');
      await homeRobot.addDelay(5000);
      await topRatedTvsRobot.scrollListView();
      await topRatedTvsRobot.back();
      await homeRobot.findTitle();
      await homeRobot.findTextTvs();

      // to movie list
      await homeRobot.openDrawer();
      await homeRobot.clickButton('drawer_movies');
      await homeRobot.findTextMovies();

      // test movie detail
      await homeRobot.addDelay(1000);
      await homeRobot.clickButton('now_playing_movie_1');
      await movieDetailRobot.addDelay(5000);
      await movieDetailRobot.findImage();
      await movieDetailRobot.findRating();
      await movieDetailRobot.findOverview();
      await movieDetailRobot.findRecommendation();
      await movieDetailRobot.scrollToTop();
      await movieDetailRobot.findAddIcon();
      await movieDetailRobot.clickButton('button_watchlist');
      await movieDetailRobot.findCheckIcon();
      await movieDetailRobot.findSnackBarAdded();
      await movieDetailRobot.addDelay(7000);
      await movieDetailRobot.clickButton('button_watchlist');
      await movieDetailRobot.findAddIcon();
      await movieDetailRobot.findSnackBarRemoved();
      await movieDetailRobot.scrollListView(
        isScrollVertical: true,
        finderKey: 'recommendation_movie_1',
        listKey: 'scroll_view',
      );
      await movieDetailRobot.scrollListView(
        finderKey: 'recommendation_movie_5',
        listKey: 'list_recommendation',
      );
      await movieDetailRobot.clickButton('recommendation_movie_5');
      await movieDetailRobot.findImage();
      await movieDetailRobot.findRating();
      await movieDetailRobot.findOverview();
      await movieDetailRobot.findRecommendation();
      await movieDetailRobot.back();

      // test tv detail
      await homeRobot.openDrawer();
      await homeRobot.clickButton('drawer_tvs');
      await homeRobot.addDelay(5000);
      await homeRobot.clickButton('popular_tv_0');
      await homeRobot.addDelay(5000);
      await tvDetailRobot.findImage();
      await tvDetailRobot.findRating();
      await tvDetailRobot.findOverview();
      await tvDetailRobot.findSeason();
      await tvDetailRobot.findRecommendation();
      await tvDetailRobot.scrollToTop();
      await tvDetailRobot.findAddIcon();
      await tvDetailRobot.clickButton('button_watchlist');
      await tvDetailRobot.findCheckIcon();
      await tvDetailRobot.findSnackBarAdded();
      await tvDetailRobot.addDelay(7000);
      await tvDetailRobot.clickButton('button_watchlist');
      await tvDetailRobot.findAddIcon();
      await tvDetailRobot.findSnackBarRemoved();
      await tvDetailRobot.scrollListView(
        isScrollVertical: true,
        finderKey: 'recommendation_tv_1',
        listKey: 'scroll_view',
      );
      await tvDetailRobot.scrollListView(
        finderKey: 'recommendation_tv_5',
        listKey: 'list_recommendation',
      );
      await tvDetailRobot.clickButton('recommendation_tv_5');
      await tvDetailRobot.findImage();
      await tvDetailRobot.findRating();
      await tvDetailRobot.findOverview();
      await tvDetailRobot.findSeason();
      await tvDetailRobot.findRecommendation();
      await tvDetailRobot.back();

      // test search tv
      await homeRobot.findTextTvs();
      await homeRobot.findSearch();
      await homeRobot.clickButton('button_search');
      await tvSearchRobot.findTitle();
      await tvSearchRobot.findTextField();
      await tvSearchRobot.findText();
      await tvSearchRobot.back();
      await homeRobot.findTextTvs();
      await homeRobot.findSearch();
      await homeRobot.clickButton('button_search');
      await tvSearchRobot.findTitle();
      await tvSearchRobot.findTextField();
      await tvSearchRobot.findText();
      await tvSearchRobot.insertText();
      await tvSearchRobot.addDelay(5000);
      await tvSearchRobot.findItemSearch();
      await homeRobot.clickButton('search_0');
      await tvDetailRobot.addDelay(5000);
      await tvDetailRobot.findImage();
      await tvDetailRobot.findRating();
      await tvDetailRobot.findOverview();
      await tvDetailRobot.findSeason();
      await tvDetailRobot.findRecommendation();
      await tvDetailRobot.back();
      await tvSearchRobot.back();

      // test search movie
      await homeRobot.openDrawer();
      await homeRobot.clickButton('drawer_movies');
      await homeRobot.findTextMovies();
      await homeRobot.findSearch();
      await homeRobot.clickButton('button_search');
      await searchRobot.findTitle();
      await searchRobot.findTextField();
      await searchRobot.findText();
      await searchRobot.back();
      await homeRobot.findTextMovies();
      await homeRobot.findSearch();
      await homeRobot.clickButton('button_search');
      await searchRobot.findTitle();
      await searchRobot.findTextField();
      await searchRobot.findText();
      await searchRobot.insertText();
      await searchRobot.addDelay(5000);
      await searchRobot.findItemSearch();
      await homeRobot.clickButton('search_0');
      await movieDetailRobot.addDelay(5000);
      await movieDetailRobot.findImage();
      await movieDetailRobot.findRating();
      await movieDetailRobot.findOverview();
      await movieDetailRobot.findRecommendation();
    });
  });
}
