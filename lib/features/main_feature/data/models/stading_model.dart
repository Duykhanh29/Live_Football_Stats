// To parse this JSON data, do
//
//     final standingModel = standingModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/data/models/league_model_response.dart';
import 'package:live_football_stats/features/main_feature/data/models/season.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart'
    as standingEntity;

StandingModel standingModelFromJson(String str) =>
    StandingModel.fromJson(json.decode(str));

String standingModelToJson(StandingModel data) => json.encode(data.toJson());

class StandingModel {
  CountryModel country;
  LeagueModelResponse league;
  SeasonModel season;
  List<Stage> stage;

  StandingModel({
    required this.country,
    required this.league,
    required this.season,
    required this.stage,
  });

  factory StandingModel.fromJson(Map<String, dynamic> json) => StandingModel(
        country: CountryModel.fromJson(json["country"]),
        league: LeagueModelResponse.fromJson(json["league"]),
        season: SeasonModel.fromJson(json["season"]),
        stage: List<Stage>.from(json["stage"].map((x) => Stage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "country": country.toJson(),
        "league": league.toJson(),
        "season": season.toJson(),
        "stage": List<dynamic>.from(stage.map((x) => x.toJson())),
      };
  standingEntity.StandingEntities toEntity() {
    return standingEntity.StandingEntities(
        country: country.toEntity(),
        league: league.toEntity(),
        season: season.toEntity(),
        stage: stage.map((e) => e.toEntity()).toList());
  }
}

class Stage {
  int stageId;
  String stageName;
  bool hasGroups;
  bool isActive;
  List<Standing> standings;

  Stage({
    required this.stageId,
    required this.stageName,
    required this.hasGroups,
    required this.isActive,
    required this.standings,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        stageId: json["stage_id"],
        stageName: json["stage_name"],
        hasGroups: json["has_groups"],
        isActive: json["is_active"],
        standings: List<Standing>.from(
            json["standings"].map((x) => Standing.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stage_id": stageId,
        "stage_name": stageName,
        "has_groups": hasGroups,
        "is_active": isActive,
        "standings": List<dynamic>.from(standings.map((x) => x.toJson())),
      };
  standingEntity.Stage toEntity() {
    return standingEntity.Stage(
        stageId: stageId,
        stageName: stageName,
        hasGroups: hasGroups,
        isActive: isActive,
        standings: standings.map((e) => e.toEntity()).toList());
  }
}

class Standing {
  int position;
  int teamId;
  String teamName;
  String positionAttribute;
  int gamesPlayed;
  int points;
  int wins;
  int draws;
  int losses;
  int goalsFor;
  int goalsAgainst;

  Standing({
    required this.position,
    required this.teamId,
    required this.teamName,
    required this.positionAttribute,
    required this.gamesPlayed,
    required this.points,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalsFor,
    required this.goalsAgainst,
  });

  factory Standing.fromJson(Map<String, dynamic> json) => Standing(
        position: json["position"],
        teamId: json["team_id"],
        teamName: json["team_name"],
        positionAttribute: json["position_attribute"],
        gamesPlayed: json["games_played"],
        points: json["points"],
        wins: json["wins"],
        draws: json["draws"],
        losses: json["losses"],
        goalsFor: json["goals_for"],
        goalsAgainst: json["goals_against"],
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "team_id": teamId,
        "team_name": teamName,
        "position_attribute": positionAttribute,
        "games_played": gamesPlayed,
        "points": points,
        "wins": wins,
        "draws": draws,
        "losses": losses,
        "goals_for": goalsFor,
        "goals_against": goalsAgainst,
      };
  standingEntity.Standing toEntity() {
    return standingEntity.Standing(
        position: position,
        teamId: teamId,
        teamName: teamName,
        positionAttribute: positionAttribute,
        gamesPlayed: gamesPlayed,
        points: points,
        wins: wins,
        draws: draws,
        losses: losses,
        goalsFor: goalsFor,
        goalsAgainst: goalsAgainst);
  }
}
