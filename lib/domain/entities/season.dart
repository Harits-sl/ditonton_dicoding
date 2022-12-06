import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int episodeCount;
  final int id;
  final String name;
  final String posterPath;
  final int seasonNumber;

  Season({
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object> get props {
    return [
      episodeCount,
      id,
      name,
      posterPath,
      seasonNumber,
    ];
  }
}
