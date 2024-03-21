import 'package:equatable/equatable.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_event.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/season.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';

class LeagueMatches extends Equatable {
  final int? leagueID;
  final String? leagueName;
  final Season? season;
  final Country? country;
  final bool? isCup;
  final List<Stage>? stage;
  LeagueMatches(
      {required this.country,
      required this.isCup,
      required this.leagueID,
      required this.leagueName,
      required this.season,
      required this.stage});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [leagueID, leagueName, country, isCup, stage, season];
}

class Stage extends Equatable {
  int? id;
  String? name;
  bool? isActive;
  List<LeagueMatch>? matches;
  Stage(
      {required this.id,
      required this.isActive,
      required this.matches,
      required this.name});
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, matches, isActive];
}

class LeagueMatch extends Equatable {
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
  List<MatchEvent>? events;
  Odds? odds;
  MatchPreview? matchPreview;
  LeagueMatch(
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        date,
        id,
        minute,
        winner,
        time,
        teams,
        odds,
        status,
        matchPreview,
        hasExtraTime,
        hasPenalties,
        events,
        goals
      ];
}
