import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/bloc/tv_detail_cubit.dart';
import 'package:tv/presentation/bloc/tv_recommendation_cubit.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';

class TvDetailPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvDetailPage({super.key, required this.id});

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailCubit>().fetchTvDetail(widget.id);
      context.read<TvRecommendationCubit>().fetchTvRecommendation(widget.id);
      context.read<TvWatchlistBloc>().add(LoadTvWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isAddedToWatchlist = context.select((TvWatchlistBloc bloc) {
      if (bloc.state is TvWatchlistStatus) {
        return (bloc.state as TvWatchlistStatus).isAddedToTvWatchlist;
      } else {
        return false;
      }
    });

    return Scaffold(
      body: BlocBuilder<TvDetailCubit, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tv = state.tv;
            return SafeArea(
              child: DetailContent(
                tv,
                isAddedToWatchlist,
              ),
            );
          } else if (state is TvDetailError) {
            return Text(state.message);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TvDetail tv;
  final bool isAddedWatchlist;

  const DetailContent(this.tv, this.isAddedWatchlist, {super.key});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  late bool _isAddedWatchlist;

  @override
  void initState() {
    super.initState();

    _isAddedWatchlist = widget.isAddedWatchlist;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        key: const Key('scroll_view'),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              key: const Key('button_watchlist'),
                              onPressed: () async {
                                if (!_isAddedWatchlist) {
                                  context.read<TvWatchlistBloc>().add(
                                      OnButtonAddTvWatchlistTapped(widget.tv));
                                } else {
                                  context.read<TvWatchlistBloc>().add(
                                      OnButtonRemoveTvWatchlistTapped(
                                          widget.tv));
                                }
                                var state =
                                    context.read<TvWatchlistBloc>().state;
                                String message = '';

                                if (state is TvWatchlistStatus) {
                                  final isAdded = state.isAddedToTvWatchlist;
                                  message = !isAdded
                                      ? ADDED_MESSAGE_WATCHLIST
                                      : REMOVED_MESSAGE_WATCHLIST;
                                } else if (state is TvWatchlistError) {
                                  message = state.message;
                                } else {
                                  message = !_isAddedWatchlist
                                      ? ADDED_MESSAGE_WATCHLIST
                                      : REMOVED_MESSAGE_WATCHLIST;
                                }

                                if (message == ADDED_MESSAGE_WATCHLIST ||
                                    message == REMOVED_MESSAGE_WATCHLIST) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(message),
                                      );
                                    },
                                  );
                                }

                                setState(() {
                                  _isAddedWatchlist = !_isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              showGenres(widget.tv.genres),
                            ),
                            Text(
                              widget.tv.episodeRunTime.isNotEmpty
                                  ? showDuration(widget.tv.episodeRunTime[0])
                                  : '',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.tv.seasons.length,
                                itemBuilder: ((context, index) {
                                  return CardSeason(widget.tv.seasons[index]);
                                }),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationCubit,
                                TvRecommendationState>(
                              builder: (context, state) {
                                if (state is TvRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvRecommendationError) {
                                  return Text(state.message);
                                } else if (state is TvRecommendationHasData &&
                                    state.tvs.isNotEmpty) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      key: const Key('list_recommendation'),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.tvs.length,
                                      itemBuilder: (context, index) {
                                        final movie = state.tvs[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            key:
                                                Key('recommendation_tv_$index'),
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Container(
                                    key: const Key('empty recommendation'),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              key: const Key('back_button'),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}

class CardSeason extends StatelessWidget {
  const CardSeason(this.season, {super.key});

  final Season season;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: season.posterPath != ''
                ? CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${season.posterPath}',
                    placeholder: (context, url) => const SizedBox(
                      width: 95,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Container(
                    color: kDavysGrey,
                    width: 95,
                    height: double.infinity,
                    child: const Icon(
                      Icons.image_outlined,
                      color: Colors.white70,
                      size: 34,
                    ),
                  ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            margin: const EdgeInsets.only(right: 4, top: 4),
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: kMikadoYellow,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            child: Text(
              'Season ${season.seasonNumber}\n${season.episodeCount} eps',
              style: const TextStyle(
                color: kRichBlack,
                height: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
