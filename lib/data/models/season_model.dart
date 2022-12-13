import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/season.dart';

class SeasonModel extends Equatable {
  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  SeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      airDate: json['air_date'] ?? '',
      episodeCount: json['episode_count']?.toInt() ?? 0,
      id: json['id']?.toInt() ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      seasonNumber: json['season_number']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air_date'] = this.airDate;
    data['episode_count'] = this.episodeCount;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['season_number'] = this.seasonNumber;
    return data;
  }

  Season toEntity() => Season(
        episodeCount: this.episodeCount,
        id: this.id,
        name: this.name,
        posterPath: this.posterPath,
        seasonNumber: this.seasonNumber,
      );

  @override
  List<Object> get props {
    return [
      airDate,
      episodeCount,
      id,
      name,
      overview,
      posterPath,
      seasonNumber,
    ];
  }
}
