import 'package:core/presentation/bloc/watchlist_movie_cubit.dart';
import 'package:core/presentation/bloc/watchlist_tv_cubit.dart';
import 'package:core/utils/route_observer.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      context.read<WatchlistMovieCubit>().fetchWatchlistMovies();
      context.read<WatchlistTvCubit>().fetchWatchlistTvs();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieCubit>().fetchWatchlistMovies();
    context.read<WatchlistTvCubit>().fetchWatchlistTvs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        leading: new IconButton(
          key: Key('back_button'),
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieCubit, WatchlistMovieState>(
          builder: (context, stateMovie) {
            return BlocBuilder<WatchlistTvCubit, WatchlistTvState>(
              builder: (context, stateTv) {
                if (stateMovie is WatchlistMovieLoading &&
                    stateTv is WatchlistTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (stateMovie is WatchlistMovieHasData &&
                    stateTv is WatchlistTvHasData) {
                  final movie = stateMovie.movies;
                  final tv = stateTv.tvs;
                  final List<dynamic> result = [...movie, ...tv];
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final content = result[index];
                      return content is Movie
                          ? MovieCard(content, 'watchlist_$index')
                          : TvCard(content, 'watchlist_tv_$index');
                    },
                    itemCount: result.length,
                  );
                } else if (stateMovie is WatchlistMovieError &&
                    stateTv is WatchlistTvError) {
                  return Center(
                    key: Key('error_message'),
                    child: Text(stateMovie.message),
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
