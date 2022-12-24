import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/popular_tvs_cubit.dart';

class PopularTvsPage extends StatefulWidget {
  static const String ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => context.read<PopularTvsCubit>().fetchPopularTvs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tvs'),
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
        child: BlocBuilder<PopularTvsCubit, PopularTvsState>(
          builder: (context, state) {
            if (state is PopularTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvsHasData) {
              return ListView.builder(
                key: const Key('list_popular'),
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return TvCard(movie, 'popular_$index');
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTvsError) {
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
