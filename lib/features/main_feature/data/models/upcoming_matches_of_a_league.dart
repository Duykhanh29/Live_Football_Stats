import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/data/models/team_model_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart'
    as upcomingEntity;

class UpcomingMatchesModel {
  int? count;
  String? updatedAt;
  List<UpcomingMatchesOfLeague>? results;
  UpcomingMatchesModel({this.count, this.results, this.updatedAt});
  factory UpcomingMatchesModel.fromJson(Map<String, dynamic> json) {
    return UpcomingMatchesModel(
        count: json['count'],
        results: json['results'] != null
            ? (json['results'] as List<dynamic>)
                .map((e) => UpcomingMatchesOfLeague.fromJson(e))
                .toList()
            : null,
        updatedAt: json['updated_at']);
  }
  Map<String, dynamic> toJson() => {
        'count': count,
        'updated_at': updatedAt,
        // ignore: prefer_null_aware_operators
        'results':
            results != null ? results!.map((e) => e.toJson()).toList() : null
      };
  upcomingEntity.UpcomingMatches toEntity() {
    return upcomingEntity.UpcomingMatches(
        results:
            results != null ? results!.map((e) => e.toEntity()).toList() : null,
        updatedAt: updatedAt,
        count: count);
  }
}

class UpcomingMatchesOfLeague {
  int? leagueID;
  String? leagueName;
  CountryModel? country;
  bool isCup;
  List<MatchPreview>? matchPreviews;
  UpcomingMatchesOfLeague(
      {this.country,
      this.isCup = false,
      this.leagueID,
      this.leagueName,
      this.matchPreviews});
  factory UpcomingMatchesOfLeague.fromJson(Map<String, dynamic> json) {
    return UpcomingMatchesOfLeague(
        isCup: json['is_cup'] != null ? json['is_cup'] : null,
        leagueID: json['league_id'] != null ? json['league_id'] : null,
        leagueName: json['league_name'] != null ? json['league_name'] : null,
        country: json['country'] != null
            ? CountryModel.fromJson(json['country'])
            : null,
        matchPreviews: json['match_previews'] != null
            ? (json['match_previews'] as List<dynamic>)
                .map((e) => MatchPreview.fromJson(e))
                .toList()
            : null);
  }
  Map<String, dynamic> toJson() => {
        'is_cup': isCup,
        'league_id': leagueID,
        'league_name': leagueName,
        'country': country!.toJson(),
        // ignore: prefer_null_aware_operators
        'match_previews': matchPreviews != null
            ? matchPreviews!.map((e) => e.toJson()).toList()
            : null
      };
  upcomingEntity.UpcomingMatchesOfLeague toEntity() {
    return upcomingEntity.UpcomingMatchesOfLeague(
        country: country != null ? country!.toEntity() : null,
        isCup: isCup,
        leagueID: leagueID,
        leagueName: leagueName,
        matchPreviews: matchPreviews != null
            ? matchPreviews!.map((e) => e.toEntity()).toList()
            : null);
  }
}

class MatchPreview {
  int? id;
  String? date, time;
  int? wordCount;
  double? exitementRating;
  Teams? teams;
  MatchPreview(
      {this.date,
      this.exitementRating,
      this.id,
      this.teams,
      this.time,
      this.wordCount});

  factory MatchPreview.fromJson(Map<String, dynamic> json) {
    return MatchPreview(
      date: json['date'] != null ? json['date'] : null,
      exitementRating:
          json['excitement_rating'] != null ? json['excitement_rating'] : null,
      id: json['id'],
      teams: Teams.fromJson(json['teams']),
      time: json['time'] != null ? json['time'] : null,
      wordCount: json['word_count'] != null ? json['word_count'] : null,
    );
  }
  Map<String, dynamic> toJson() => {
        'date': date,
        'excitement_rating': exitementRating,
        'teams': teams!.toJson(),
        'time': time,
        'id': id,
        'word_count': wordCount
      };
  upcomingEntity.MatchPreview toEntity() {
    return upcomingEntity.MatchPreview(
        date: date,
        exitementRating: exitementRating,
        id: id,
        teams: teams != null ? teams!.toEntity() : null,
        time: time,
        wordCount: wordCount);
  }
}

class Teams {
  TeamModelResponse? home, away;
  Teams({this.home, this.away});
  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
        away: TeamModelResponse.fromJson(
          json['away'],
        ),
        home: TeamModelResponse.fromJson(
          json['home'],
        ));
  }
  Map<String, dynamic> toJson() =>
      {'home': home!.toJson(), 'away': away!.toJson()};
  upcomingEntity.Teams toEntity() {
    return upcomingEntity.Teams(
        home: home != null ? home!.toEntity() : null,
        away: away != null ? away!.toEntity() : null);
  }
}
