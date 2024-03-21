import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/data/models/macth_event.dart';
import 'package:live_football_stats/features/main_feature/data/models/match_model.dart';
import 'package:live_football_stats/features/main_feature/data/models/season.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart'
    as leagueMatchesEntity;

class LeagueMatchesModel {
  final int? leagueID;
  final String? leagueName;
  final SeasonModel? season;
  final CountryModel? country;
  final bool? isCup;
  final List<Stage>? stage;
  LeagueMatchesModel(
      {required this.country,
      required this.isCup,
      required this.leagueID,
      required this.leagueName,
      required this.season,
      required this.stage});
  factory LeagueMatchesModel.fromJson(Map<String, dynamic> json) {
    return LeagueMatchesModel(
        country: json['country'] != null
            ? CountryModel.fromJson(json['country'])
            : null,
        isCup: json['is_cup'],
        leagueID: json['league_id'],
        leagueName: json['league_name'],
        season: json['season'] != null
            ? SeasonModel.fromJson(json['season'])
            : null,
        stage: json["stage"] != null
            ? List<Stage>.from(json["stage"].map((x) => Stage.fromJson(x)))
                .toList()
            : null);
  }
  leagueMatchesEntity.LeagueMatches toEntity() {
    return leagueMatchesEntity.LeagueMatches(
        country: country?.toEntity(),
        isCup: isCup,
        leagueID: leagueID,
        leagueName: leagueName,
        season: season?.toEntity(),
        stage: stage?.map((e) => e.toEntity()).toList());
  }
}

class Stage {
  int? id;
  String? name;
  bool? isActive;
  List<LeagueMatchModel>? matches;
  Stage(
      {required this.id,
      required this.isActive,
      required this.matches,
      required this.name});
  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
        id: json['stage_id'],
        isActive: json['is_active'],
        matches: json["matches"] != null
            ? List<LeagueMatchModel>.from(
                    json["matches"].map((x) => LeagueMatchModel.fromJson(x)))
                .toList()
            : null,
        name: json['stage_name']);
  }
  leagueMatchesEntity.Stage toEntity() {
    return leagueMatchesEntity.Stage(
        id: id,
        name: name,
        isActive: isActive,
        matches: matches?.map((e) => e.toEntity()).toList());
  }
}

class LeagueMatchModel {
  int? id;
  String? date;
  String? time;
  Teams? teams;
  MatchStatus? status;
  int? minute;
  Winner? winner;
  bool? hasExtraTime;
  bool? hasPenalties;
  Goals? goals;
  List<MatchEventModel>? events;
  Odds? odds;
  MatchPreview? matchPreview;
  LeagueMatchModel(
      {required this.date,
      required this.events,
      required this.goals,
      required this.hasExtraTime,
      required this.hasPenalties,
      required this.id,
      required this.matchPreview,
      required this.minute,
      required this.odds,
      required this.status,
      required this.teams,
      required this.time,
      required this.winner});
  factory LeagueMatchModel.fromJson(Map<String, dynamic> json) {
    return LeagueMatchModel(
      date: json['date'],
      events: json["events"] != null
          ? List<MatchEventModel>.from(
              json["events"].map((x) => MatchEventModel.fromJson(x))).toList()
          : null,
      goals: json['goals'] != null ? Goals.fromJson(json['goals']) : null,
      hasExtraTime: json['has_extra_time'],
      hasPenalties: json['has_penalties'],
      id: json['id'],
      matchPreview: json['match_preview'] != null
          ? MatchPreview.fromJson(json['match_preview'])
          : null,
      minute: json['minute'],
      odds: json['odds'] != null ? Odds.fromJson(json['odds']) : null,
      status:
          json['status'] != null ? matchStatusValues.map[json['status']] : null,
      teams: json['teams'] != null ? Teams.fromJson(json['teams']) : null,
      time: json['time'],
      winner: json["winner"] != null ? winnerValues.map[json["winner"]] : null,
    );
  }
  leagueMatchesEntity.LeagueMatch toEntity() {
    return leagueMatchesEntity.LeagueMatch(
      date: date,
      events: events?.map((e) => e.toEntity()).toList(),
      goals: goals?.toEntity(),
      hasExtraTime: hasExtraTime,
      hasPenalties: hasPenalties,
      id: id,
      matchPreview: matchPreview?.toEntity(),
      minute: minute,
      odds: odds?.toEntity(),
      status: status,
      teams: teams?.toEntity(),
      time: time,
      winner: winner,
    );
  }
}
