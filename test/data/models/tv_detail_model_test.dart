import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvDetailResponseModel = TvDetailResponse(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    createdBy: [
      {
        "id": 9813,
        "credit_id": "5256c8c219c2956ff604858a",
        "name": "David Benioff",
        "gender": 2,
        "profile_path": "/xvNN5huL0X8yJ7h3IZfGG4O2zBD.jpg"
      },
      {
        "id": 228068,
        "credit_id": "552e611e9251413fea000901",
        "name": "D. B. Weiss",
        "gender": 2,
        "profile_path": "/2RMejaT793U9KRk2IEbFfteQntE.jpg"
      }
    ],
    episodeRunTime: [60],
    firstAirDate: "2011-04-17",
    genres: [
      GenreModel(id: 10765, name: "Sci-Fi & Fantasy"),
      GenreModel(id: 18, name: "Drama"),
      GenreModel(id: 10759, name: "Action & Adventure"),
      GenreModel(id: 9648, name: "Mystery"),
    ],
    homepage: "http://www.hbo.com/game-of-thrones",
    id: 1399,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "2019-05-19",
    lastEpisodeToAir: {
      "air_date": "2019-05-19",
      "episode_number": 6,
      "id": 1551830,
      "name": "The Iron Throne",
      "overview":
          "In the aftermath of the devastating attack on King's Landing, Daenerys must face the survivors.",
      "production_code": "806",
      "season_number": 8,
      "still_path": "/3x8tJon5jXFa1ziAM93hPKNyW7i.jpg",
      "vote_average": 4.8,
      "vote_count": 106
    },
    name: "Game of Thrones",
    nextEpisodeToAir: null,
    networks: [
      {
        "name": "HBO",
        "id": 49,
        "logo_path": "/tuomPhY2UtuPTqqFnKMVHvSb724.png",
        "origin_country": "US"
      }
    ],
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 369.594,
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    productionCompanies: [
      {
        "id": 76043,
        "logo_path": "/9RO2vbQ67otPrBLXCaC8UMp3Qat.png",
        "name": "Revolution Sun Studios",
        "origin_country": "US"
      }
    ],
    productionCountries: [
      {"iso_3166_1": "GB", "name": "United Kingdom"}
    ],
    seasons: [
      SeasonModel(
        airDate: "2010-12-05",
        episodeCount: 64,
        id: 3627,
        name: "Specials",
        overview: "",
        posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
        seasonNumber: 0,
      )
    ],
    spokenLanguages: [
      {"english_name": "English", "iso_639_1": "en", "name": "English"}
    ],
    status: "Ended",
    tagline: "Winter Is Coming",
    type: "Scripted",
    voteAverage: 8.3,
    voteCount: 11504,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));
      // act
      final result = TvDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvDetailResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvDetailResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "backdrop_path": "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
        "created_by": [
          {
            "id": 9813,
            "credit_id": "5256c8c219c2956ff604858a",
            "name": "David Benioff",
            "gender": 2,
            "profile_path": "/xvNN5huL0X8yJ7h3IZfGG4O2zBD.jpg"
          },
          {
            "id": 228068,
            "credit_id": "552e611e9251413fea000901",
            "name": "D. B. Weiss",
            "gender": 2,
            "profile_path": "/2RMejaT793U9KRk2IEbFfteQntE.jpg"
          }
        ],
        "episode_run_time": [60],
        "first_air_date": "2011-04-17",
        "genres": [
          GenreModel(id: 10765, name: "Sci-Fi & Fantasy").toJson(),
          GenreModel(id: 18, name: "Drama").toJson(),
          GenreModel(id: 10759, name: "Action & Adventure").toJson(),
          GenreModel(id: 9648, name: "Mystery").toJson(),
        ],
        "homepage": "http://www.hbo.com/game-of-thrones",
        "id": 1399,
        "in_production": false,
        "languages": ["en"],
        "last_air_date": "2019-05-19",
        "last_episode_to_air": {
          "air_date": "2019-05-19",
          "episode_number": 6,
          "id": 1551830,
          "name": "The Iron Throne",
          "overview":
              "In the aftermath of the devastating attack on King's Landing, Daenerys must face the survivors.",
          "production_code": "806",
          "season_number": 8,
          "still_path": "/3x8tJon5jXFa1ziAM93hPKNyW7i.jpg",
          "vote_average": 4.8,
          "vote_count": 106
        },
        "name": "Game of Thrones",
        "next_episode_to_air": null,
        "networks": [
          {
            "name": "HBO",
            "id": 49,
            "logo_path": "/tuomPhY2UtuPTqqFnKMVHvSb724.png",
            "origin_country": "US"
          }
        ],
        "number_of_episodes": 73,
        "number_of_seasons": 8,
        "origin_country": ["US"],
        "original_language": "en",
        "original_name": "Game of Thrones",
        "overview":
            "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
        "popularity": 369.594,
        "poster_path": "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
        "production_companies": [
          {
            "id": 76043,
            "logo_path": "/9RO2vbQ67otPrBLXCaC8UMp3Qat.png",
            "name": "Revolution Sun Studios",
            "origin_country": "US"
          }
        ],
        "production_countries": [
          {"iso_3166_1": "GB", "name": "United Kingdom"}
        ],
        "seasons": [
          SeasonModel(
            airDate: "2010-12-05",
            episodeCount: 64,
            id: 3627,
            name: "Specials",
            overview: "",
            posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
            seasonNumber: 0,
          ).toJson()
        ],
        "spoken_languages": [
          {"english_name": "English", "iso_639_1": "en", "name": "English"}
        ],
        "status": "Ended",
        "tagline": "Winter Is Coming",
        "type": "Scripted",
        "vote_average": 8.3,
        "vote_count": 11504,
      };
      expect(result, expectedJsonMap);
    });
  });
}
