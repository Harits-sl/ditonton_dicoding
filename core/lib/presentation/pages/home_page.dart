import 'package:core/presentation/bloc/home_bloc.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
// import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

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
              key: Key('drawer_movies'),
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                context.read<HomeBloc>().add(OnMoviesTapped());
                Navigator.pop(context);
              },
            ),
            ListTile(
              key: Key('drawer_tvs'),
              leading: Icon(Icons.tv),
              title: Text('Tvs'),
              onTap: () {
                context.read<HomeBloc>().add(OnTvsTapped());
                Navigator.pop(context);
              },
            ),
            ListTile(
              key: Key('drawer_watchlist'),
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              key: Key('drawer_about'),
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
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
            key: (Key('button_search')),
            onPressed: () {
              var bodyState = context.read<HomeBloc>().state;
              if (bodyState is HomeMovies) {
                Navigator.pushNamed(context, SEARCH_ROUTE);
              } else {
                Navigator.pushNamed(context, SEARCH_TV_ROUTE);
              }
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeMovies) {
            return HomeMoviePage();
          } else {
            return HomeTvPage();
          }
        },
      ),
    );
  }
}
