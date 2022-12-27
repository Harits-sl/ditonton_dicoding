import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/now_playing_tvs_cubit.dart';

class NowPlayingTvsPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String ROUTE_NAME = '/now-playing-tv';

  const NowPlayingTvsPage({super.key});

  @override
  State<NowPlayingTvsPage> createState() => _NowPlayingTvsPageState();
}

class _NowPlayingTvsPageState extends State<NowPlayingTvsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => context.read<NowPlayingTvsCubit>().fetchNowPlayingTvs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Tvs'),
        leading: IconButton(
          key: const Key('back_button'),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvsCubit, NowPlayingTvsState>(
          builder: (context, state) {
            if (state is NowPlayingTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvsHasData) {
              return ListView.builder(
                key: const Key('list_now_playing'),
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return TvCard(movie, 'now_playing_$index');
                },
                itemCount: state.result.length,
              );
            } else if (state is NowPlayingTvsError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
