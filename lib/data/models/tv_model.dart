import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv.dart';

class TvModel extends Equatable {
  TvModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.genreIds,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final String firstAirDate;
  final List<int> genreIds;
  final int voteCount;
  final String name;
  final String originalName;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: json["first_air_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
      };

  Tv toEntity() => Tv(
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        firstAirDate: firstAirDate,
        name: name,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

  @override
  List<Object?> get props {
    return [
      posterPath,
      popularity,
      id,
      backdropPath,
      voteAverage,
      overview,
      firstAirDate,
      genreIds,
      voteCount,
      name,
      originalName,
    ];
  }
}
