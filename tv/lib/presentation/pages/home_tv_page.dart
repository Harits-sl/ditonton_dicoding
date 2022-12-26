import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/now_playing_tvs_cubit.dart';
import 'package:tv/presentation/bloc/popular_tvs_cubit.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_cubit.dart';
import 'package:tv/presentation/pages/now_playing_tvs_page.dart';
import 'package:tv/presentation/pages/popular_tvs_page.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({super.key});

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<NowPlayingTvsCubit>().fetchNowPlayingTvs();
        context.read<PopularTvsCubit>().fetchPopularTvs();
        context.read<TopRatedTvsCubit>().fetchTopRatedTvs();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        key: const Key('scroll_tv'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeading(
              title: 'Now Playing Tvs',
              buttonKey: 'now_playing',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingTvsPage.ROUTE_NAME),
            ),
            BlocBuilder<NowPlayingTvsCubit, NowPlayingTvsState>(
              builder: (context, state) {
                if (state is NowPlayingTvsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTvsHasData) {
                  return TvList(
                    'now_playing_tv',
                    state.result,
                  );
                } else if (state is NowPlayingTvsError) {
                  return const Text('Failed');
                } else {
                  return const SizedBox();
                }
              },
            ),
            SubHeading(
              title: 'Popular Tvs',
              buttonKey: 'popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularTvsCubit, PopularTvsState>(
              builder: (context, state) {
                if (state is PopularTvsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvsHasData) {
                  return TvList(
                    'popular_tv',
                    state.result,
                  );
                } else if (state is PopularTvsError) {
                  return const Text('Failed');
                } else {
                  return const SizedBox();
                }
              },
            ),
            SubHeading(
              title: 'Top Rated Tvs',
              buttonKey: 'top_rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedTvsCubit, TopRatedTvsState>(
              builder: (context, state) {
                if (state is TopRatedTvsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvsHasData) {
                  return TvList(
                    'top_rated_tv',
                    state.result,
                  );
                } else if (state is TopRatedTvsError) {
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

class TvList extends StatelessWidget {
  final String keyListView;
  final List<Tv> tvs;

  const TvList(this.keyListView, this.tvs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        key: Key(keyListView),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              key: Key('${keyListView}_$index'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
