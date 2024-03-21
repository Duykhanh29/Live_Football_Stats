import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';

class UpcomingMatches extends Equatable {
  int? count;
  String? updatedAt;
  List<UpcomingMatchesOfLeague>? results;
  UpcomingMatches({this.count, this.results, this.updatedAt});

  @override
  // TODO: implement props
  List<Object?> get props => [count, updatedAt, results];
}

class UpcomingMatchesOfLeague extends Equatable {
  int? leagueID;
  String? leagueName;
  Country? country;
  bool isCup;
  List<MatchPreview>? matchPreviews;
  UpcomingMatchesOfLeague(
      {this.country,
      this.isCup = false,
      this.leagueID,
      this.leagueName,
      this.matchPreviews});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [matchPreviews, leagueName, leagueID, isCup, country];
}

class MatchPreview extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props =>
      [wordCount, time, teams, id, exitementRating, date];
}

class Teams extends Equatable {
  TeamResponse? home, away;
  Teams({this.home, this.away});

  @override
  // TODO: implement props
  List<Object?> get props => [home, away];
}
