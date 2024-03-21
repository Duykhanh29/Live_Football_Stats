// To parse this JSON data, do
//
//     final headToHeadModel = headToHeadModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/features/main_feature/data/models/team_model_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/head_to_head.dart'
    as headToHeadEntity;

HeadToHeadModel headToHeadModelFromJson(String str) =>
    HeadToHeadModel.fromJson(json.decode(str));

String headToHeadModelToJson(HeadToHeadModel data) =>
    json.encode(data.toJson());

class HeadToHeadModel {
  TeamModelResponse? team1;
  TeamModelResponse? team2;
  Stats? stats;

  HeadToHeadModel({
    required this.team1,
    required this.team2,
    required this.stats,
  });

  factory HeadToHeadModel.fromJson(Map<String, dynamic> json) =>
      HeadToHeadModel(
        team1: TeamModelResponse.fromJson(json["team1"]),
        team2: TeamModelResponse.fromJson(json["team2"]),
        stats: Stats.fromJson(json["stats"]),
      );

  Map<String, dynamic> toJson() => {
        "team1": team1?.toJson(),
        "team2": team2?.toJson(),
        "stats": stats?.toJson(),
      };
  headToHeadEntity.HeadToHead toEntity() {
    return headToHeadEntity.HeadToHead(
        team1: team1?.toEntity(),
        team2: team2?.toEntity(),
        stats: stats?.toEntity());
  }
}

class Stats {
  Overall? overall;
  Team1AtHome? team1AtHome;
  Team2AtHome? team2AtHome;

  Stats({
    required this.overall,
    required this.team1AtHome,
    required this.team2AtHome,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        overall: Overall.fromJson(json["overall"]),
        team1AtHome: Team1AtHome.fromJson(json["team1_at_home"]),
        team2AtHome: Team2AtHome.fromJson(json["team2_at_home"]),
      );

  Map<String, dynamic> toJson() => {
        "overall": overall?.toJson(),
        "team1_at_home": team1AtHome?.toJson(),
        "team2_at_home": team2AtHome?.toJson(),
      };
  headToHeadEntity.Stats toEntity() {
    return headToHeadEntity.Stats(
        overall: overall?.toEntity(),
        team1AtHome: team1AtHome?.toEntity(),
        team2AtHome: team2AtHome?.toEntity());
  }
}

class Overall {
  int? overallGamesPlayed;
  int? overallTeam1Wins;
  int? overallTeam2Wins;
  int? overallDraws;
  int? overallTeam1Scored;
  int? overallTeam2Scored;

  Overall({
    required this.overallGamesPlayed,
    required this.overallTeam1Wins,
    required this.overallTeam2Wins,
    required this.overallDraws,
    required this.overallTeam1Scored,
    required this.overallTeam2Scored,
  });

  factory Overall.fromJson(Map<String, dynamic> json) => Overall(
        overallGamesPlayed: json["overall_games_played"],
        overallTeam1Wins: json["overall_team1_wins"],
        overallTeam2Wins: json["overall_team2_wins"],
        overallDraws: json["overall_draws"],
        overallTeam1Scored: json["overall_team1_scored"],
        overallTeam2Scored: json["overall_team2_scored"],
      );

  Map<String, dynamic> toJson() => {
        "overall_games_played": overallGamesPlayed,
        "overall_team1_wins": overallTeam1Wins,
        "overall_team2_wins": overallTeam2Wins,
        "overall_draws": overallDraws,
        "overall_team1_scored": overallTeam1Scored,
        "overall_team2_scored": overallTeam2Scored,
      };
  headToHeadEntity.Overall toEntity() {
    return headToHeadEntity.Overall(
        overallGamesPlayed: overallGamesPlayed,
        overallTeam1Wins: overallTeam1Wins,
        overallTeam2Wins: overallTeam2Wins,
        overallDraws: overallDraws,
        overallTeam1Scored: overallTeam1Scored,
        overallTeam2Scored: overallTeam2Scored);
  }
}

class Team1AtHome {
  int? team1GamesPlayedAtHome;
  int? team1WinsAtHome;
  int? team1LossesAtHome;
  int? team1DrawsAtHome;
  int? team1ScoredAtHome;
  int? team1ConcededAtHome;

  Team1AtHome({
    required this.team1GamesPlayedAtHome,
    required this.team1WinsAtHome,
    required this.team1LossesAtHome,
    required this.team1DrawsAtHome,
    required this.team1ScoredAtHome,
    required this.team1ConcededAtHome,
  });

  factory Team1AtHome.fromJson(Map<String, dynamic> json) => Team1AtHome(
        team1GamesPlayedAtHome: json["team1_games_played_at_home"],
        team1WinsAtHome: json["team1_wins_at_home"],
        team1LossesAtHome: json["team1_losses_at_home"],
        team1DrawsAtHome: json["team1_draws_at_home"],
        team1ScoredAtHome: json["team1_scored_at_home"],
        team1ConcededAtHome: json["team1_conceded_at_home"],
      );

  Map<String, dynamic> toJson() => {
        "team1_games_played_at_home": team1GamesPlayedAtHome,
        "team1_wins_at_home": team1WinsAtHome,
        "team1_losses_at_home": team1LossesAtHome,
        "team1_draws_at_home": team1DrawsAtHome,
        "team1_scored_at_home": team1ScoredAtHome,
        "team1_conceded_at_home": team1ConcededAtHome,
      };
  headToHeadEntity.Team1AtHome toEntity() {
    return headToHeadEntity.Team1AtHome(
        team1GamesPlayedAtHome: team1GamesPlayedAtHome,
        team1WinsAtHome: team1WinsAtHome,
        team1LossesAtHome: team1LossesAtHome,
        team1DrawsAtHome: team1DrawsAtHome,
        team1ScoredAtHome: team1ScoredAtHome,
        team1ConcededAtHome: team1ConcededAtHome);
  }
}

class Team2AtHome {
  int? team2GamesPlayedAtHome;
  int? team2WinsAtHome;
  int? team2LossesAtHome;
  int? team2DrawsAtHome;
  int? team2ScoredAtHome;
  int? team2ConcededAtHome;

  Team2AtHome({
    required this.team2GamesPlayedAtHome,
    required this.team2WinsAtHome,
    required this.team2LossesAtHome,
    required this.team2DrawsAtHome,
    required this.team2ScoredAtHome,
    required this.team2ConcededAtHome,
  });

  factory Team2AtHome.fromJson(Map<String, dynamic> json) => Team2AtHome(
        team2GamesPlayedAtHome: json["team2_games_played_at_home"],
        team2WinsAtHome: json["team2_wins_at_home"],
        team2LossesAtHome: json["team2_losses_at_home"],
        team2DrawsAtHome: json["team2_draws_at_home"],
        team2ScoredAtHome: json["team2_scored_at_home"],
        team2ConcededAtHome: json["team2_conceded_at_home"],
      );

  Map<String, dynamic> toJson() => {
        "team2_games_played_at_home": team2GamesPlayedAtHome,
        "team2_wins_at_home": team2WinsAtHome,
        "team2_losses_at_home": team2LossesAtHome,
        "team2_draws_at_home": team2DrawsAtHome,
        "team2_scored_at_home": team2ScoredAtHome,
        "team2_conceded_at_home": team2ConcededAtHome,
      };
  headToHeadEntity.Team2AtHome toEntity() {
    return headToHeadEntity.Team2AtHome(
        team2GamesPlayedAtHome: team2GamesPlayedAtHome,
        team2WinsAtHome: team2WinsAtHome,
        team2LossesAtHome: team2LossesAtHome,
        team2DrawsAtHome: team2DrawsAtHome,
        team2ScoredAtHome: team2ScoredAtHome,
        team2ConcededAtHome: team2ConcededAtHome);
  }
}
