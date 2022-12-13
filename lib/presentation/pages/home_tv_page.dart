import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/now_playing_tvs_page.dart';
import 'package:ditonton/presentation/pages/popular_tvs_page.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTvPage extends StatefulWidget {
  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchNowPlayingTvs()
      ..fetchPopularTvs()
      ..fetchTopRatedTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        key: Key('scroll_tv'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeading(
              title: 'Now Playing Tvs',
              buttonKey: 'now_playing',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingTvsPage.ROUTE_NAME),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingState;

              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList('now_playing_tvs', data.nowPlayingTvs);
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              title: 'Popular Tvs',
              buttonKey: 'popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.popularState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList('popular_tvs', data.popularTvs);
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              title: 'Top Rated Tvs',
              buttonKey: 'top_rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.topRatedState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList('top_rated_tvs', data.topRatedTvs);
              } else {
                return Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final String keyListView;
  final List<Tv> tvs;

  TvList(this.keyListView, this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
