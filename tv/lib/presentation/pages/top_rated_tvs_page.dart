import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_cubit.dart';

class TopRatedTvsPage extends StatefulWidget {
  static const String ROUTE_NAME = '/top-rated-tv';

  const TopRatedTvsPage({super.key});

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => context.read<TopRatedTvsCubit>().fetchTopRatedTvs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tvs'),
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
        child: BlocBuilder<TopRatedTvsCubit, TopRatedTvsState>(
          builder: (context, state) {
            if (state is TopRatedTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvsHasData) {
              return ListView.builder(
                key: const Key('list_top_rated'),
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return TvCard(movie, 'top_rated_$index');
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedTvsError) {
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
