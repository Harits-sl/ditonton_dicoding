import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/now_playing_movies_cubit.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<NowPlayingMoviesCubit>().fetchNowPlayingMovies();
        context.read<PopularMoviesCubit>().fetchPopularMovies();
        context.read<TopRatedMoviesCubit>().fetchTopRatedMovies();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        key: const Key('scroll_view'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
              builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMoviesHasData) {
                  log(state.toString());
                  return MovieList(
                    'now_playing_movie',
                    state.result,
                  );
                } else if (state is NowPlayingMoviesError) {
                  return const Text('Failed');
                } else {
                  return const SizedBox();
                }
              },
            ),
            SubHeading(
              title: 'Popular',
              buttonKey: 'popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesHasData) {
                  return MovieList(
                    'popular_movie',
                    state.result,
                  );
                } else if (state is PopularMoviesError) {
                  return const Text('Failed');
                } else {
                  return const SizedBox();
                }
              },
            ),
            SubHeading(
              title: 'Top Rated',
              buttonKey: 'top_rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
              builder: (context, state) {
                if (state is TopRatedMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMoviesHasData) {
                  return MovieList(
                    'top_rated_movie',
                    state.result,
                  );
                } else if (state is TopRatedMoviesError) {
                  return const Text('Failed');
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final String keyListView;
  final List<Movie> movies;

  const MovieList(this.keyListView, this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        key: Key(keyListView),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              key: Key('${keyListView}_$index'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
