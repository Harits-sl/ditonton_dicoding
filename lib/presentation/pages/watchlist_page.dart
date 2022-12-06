import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvNotifier>(context, listen: false)
          .fetchWatchlistTvs();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false)
        .fetchWatchlistTvs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer2<WatchlistMovieNotifier, WatchlistTvNotifier>(
          builder: (context, movieData, tvData, child) {
            final movie = movieData.watchlistMovies;
            final tv = tvData.watchlistTvs;
            final List<dynamic> result = [...movie, ...tv];
            if (movieData.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (movieData.watchlistState == RequestState.Loaded) {
              // return ListView.builder(
              //   itemBuilder: (context, index) {
              //     final content = result[index];
              //     return ContentCardList(content: content);
              //   },
              //   itemCount: result.length,
              // );
              return ContentCardList(content: result);
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(movieData.message),
              );
            }
          },
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Consumer<WatchlistTvNotifier>(
      //     builder: (context, data, child) {
      //       if (data.watchlistState == RequestState.Loading) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else if (data.watchlistState == RequestState.Loaded) {
      //         return ListView.builder(
      //           itemBuilder: (context, index) {
      //             final tv = data.watchlistTvs[index];
      //             return TvCard(tv);
      //           },
      //           itemCount: data.watchlistTvs.length,
      //         );
      //       } else {
      //         return Center(
      //           key: Key('error_message'),
      //           child: Text(data.message),
      //         );
      //       }
      //     },
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
