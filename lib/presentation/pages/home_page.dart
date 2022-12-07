import 'package:ditonton/common/body_state_enum.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/tv_search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Provider.of<HomeNotifier>(context, listen: false)
                    .changeToMovie();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tvs'),
              onTap: () {
                Provider.of<HomeNotifier>(context, listen: false).changeToTv();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              var bodyState =
                  Provider.of<HomeNotifier>(context, listen: false).bodyState;
              if (bodyState == BodyState.Movie) {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              } else {
                Navigator.pushNamed(context, TvSearchPage.ROUTE_NAME);
              }
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<HomeNotifier>(
        builder: (context, data, _) {
          if (data.bodyState == BodyState.Movie) {
            return HomeMoviePage();
          } else {
            return HomeTvPage();
          }
        },
      ),
    );
  }
}
