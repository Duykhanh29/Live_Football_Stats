import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/season.dart';

class StandingEntities extends Equatable {
  Country country;
  LeagueResponse league;
  Season season;
  List<Stage> stage;

  StandingEntities({
    required this.country,
    required this.league,
    required this.season,
    required this.stage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [country, league, season, stage];
}

class Stage extends Equatable {
  int stageId;
  String stageName;
  bool hasGroups;
  bool isActive;
  List<dynamic> standings;

  Stage({
    required this.stageId,
    required this.stageName,
    required this.hasGroups,
    required this.isActive,
    required this.standings,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [stageId, stageName, isActive, standings, hasGroups];
}

class GroupStandingEntities extends Equatable {
  final int groupId;
  final String groupName;
  final List<Standing> standings;

  GroupStandingEntities({
    required this.groupId,
    required this.groupName,
    required this.standings,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [groupId, groupName, standings];
}

class Standing extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        goalsAgainst,
        goalsFor,
        losses,
        draws,
        wins,
        points,
        gamesPlayed,
        position,
        teamId,
        teamName,
        positionAttribute
      ];
}
