import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';

final testTv = Tv(
  posterPath: '/jeGtaMwGxPmQN5xM4ClnwPQcNQz.jpg',
  popularity: 1397.308,
  id: 119051,
  backdropPath: '/9DpB6wC1iY5jxLz91RT8tIIsXaf.jpg',
  voteAverage: 8.8,
  overview:
      "Wednesday Addams is sent to Nevermore Academy, a bizarre boarding school where she attempts to master her psychic powers, stop a monstrous killing spree of the town citizens, and solve the supernatural mystery that affected her family 25 years ago - all while navigating her new relationships.",
  firstAirDate: '2022-11-23',
  genreIds: const [10765, 9648, 35],
  voteCount: 686,
  name: 'Wednesdayy',
  originalName: 'Wednesdayy',
);

final testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  episodeRunTime: [10],
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: '2020-1-1',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
  seasons: [
    Season(
      episodeCount: 10,
      id: 1,
      name: 'name',
      posterPath: 'posterPath',
      seasonNumber: 10,
    )
  ],
);
