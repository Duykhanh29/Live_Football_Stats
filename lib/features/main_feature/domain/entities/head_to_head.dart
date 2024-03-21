// To parse this JSON data, do
//
//     final headToHeadModel = headToHeadModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/data/models/team_model_response.dart';

class HeadToHead extends Equatable {
  TeamModelResponse? team1;
  TeamModelResponse? team2;
  Stats? stats;

  HeadToHead({
    required this.team1,
    required this.team2,
    required this.stats,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [team1, team2, stats];
}

class Stats extends Equatable {
  Overall? overall;
  Team1AtHome? team1AtHome;
  Team2AtHome? team2AtHome;

  Stats({
    required this.overall,
    required this.team1AtHome,
    required this.team2AtHome,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [overall, team1AtHome, team2AtHome];
}

class Overall extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        overallGamesPlayed,
        overallTeam1Wins,
        overallTeam2Wins,
        overallDraws,
        overallTeam1Scored,
        overallTeam2Scored
      ];
}

class Team1AtHome extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        team1GamesPlayedAtHome,
        team1WinsAtHome,
        team1LossesAtHome,
        team1DrawsAtHome,
        team1ScoredAtHome,
        team1ConcededAtHome
      ];
}

class Team2AtHome extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        team2GamesPlayedAtHome,
        team2WinsAtHome,
        team2LossesAtHome,
        team2DrawsAtHome,
        team2ScoredAtHome,
        team2ConcededAtHome
      ];
}
