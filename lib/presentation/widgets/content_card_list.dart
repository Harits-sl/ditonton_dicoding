import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class ContentCardList extends StatelessWidget {
  const ContentCardList({
    Key? key,
    required this.content,
  }) : super(key: key);

  final content;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return content[index] is Movie
            ? MovieCard(content[index] as Movie)
            : TvCard(content[index] as Tv);
      },
      itemCount: content.length,
    );
  }
}
