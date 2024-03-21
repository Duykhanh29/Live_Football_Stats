import 'package:equatable/equatable.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_event.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/sidelined_player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';

class LiveScore extends Equatable {
  int leagueId;
  String leagueName;
  Country country;
  bool isCup;
  List<Stage> stage;

  LiveScore({
    required this.leagueId,
    required this.leagueName,
    required this.country,
    required this.isCup,
    required this.stage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [leagueId, leagueName, country, stage, isCup];
}

class Stage extends Equatable {
  int stageId;
  String stageName;
  List<Match> matches;

  Stage({
    required this.stageId,
    required this.stageName,
    required this.matches,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [stageId, stageName, matches];
}

class Match extends Equatable {
  int id;
  String date;
  String time;
  Teams teams;
  Stadium? stadium;
  MatchStatus status;
  int minute;
  Winner winner;
  bool hasExtraTime;
  bool hasPenalties;
  Goals goals;
  List<MatchEvent> events;
  Odds odds;
  Lineups lineups;
  MatchPreview matchPreview;

  Match({
    required this.id,
    required this.date,
    required this.time,
    required this.teams,
    required this.stadium,
    required this.status,
    required this.minute,
    required this.winner,
    required this.hasExtraTime,
    required this.hasPenalties,
    required this.goals,
    required this.events,
    required this.odds,
    required this.lineups,
    required this.matchPreview,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        matchPreview,
        lineups,
        odds,
        goals,
        events,
        hasExtraTime,
        hasPenalties,
        winner,
        minute,
        status,
        stadium,
        teams,
        time,
        date,
        id
      ];
}

class Goals extends Equatable {
  int homeHtGoals;
  int awayHtGoals;
  int homeFtGoals;
  int awayFtGoals;
  int homeEtGoals;
  int awayEtGoals;
  int homePenGoals;
  int awayPenGoals;

  Goals({
    required this.homeHtGoals,
    required this.awayHtGoals,
    required this.homeFtGoals,
    required this.awayFtGoals,
    required this.homeEtGoals,
    required this.awayEtGoals,
    required this.homePenGoals,
    required this.awayPenGoals,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        homeHtGoals,
        awayHtGoals,
        homeFtGoals,
        awayFtGoals,
        homeEtGoals,
        awayEtGoals,
        homePenGoals,
        awayPenGoals
      ];
}

class Lineups extends Equatable {
  LineupType lineupType;
  LineupData lineups;
  Bench bench;
  Sidelined sidelined;
  Formation formation;

  Lineups({
    required this.lineupType,
    required this.lineups,
    required this.bench,
    required this.sidelined,
    required this.formation,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [lineupType, lineups, sidelined, formation, bench];
}

class LineupData extends Equatable {
  List<BenchAway> home;
  List<BenchAway> away;

  LineupData({
    required this.home,
    required this.away,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [home, away];
}

class Bench extends Equatable {
  List<BenchAway> home;
  List<BenchAway> away;

  Bench({
    required this.home,
    required this.away,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [home, away];
}

class BenchAway extends Equatable {
  Player player;
  Position position;

  BenchAway({
    required this.player,
    required this.position,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [player, position];
}

class Formation extends Equatable {
  String home;
  String away;

  Formation({
    required this.home,
    required this.away,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [home, away];
}

class Sidelined extends Equatable {
  List<SidelinedPlayer> home;
  List<SidelinedPlayer> away;

  Sidelined({
    required this.home,
    required this.away,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [home, away];
}

class MatchPreview extends Equatable {
  bool hasPreview;
  int wordCount;
  double? excitementRating;

  MatchPreview({
    required this.hasPreview,
    required this.wordCount,
    this.excitementRating,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [hasPreview, excitementRating, wordCount];
}

class Odds extends Equatable {
  MatchWinner matchWinner;
  OverUnder overUnder;
  Handicap handicap;
  int lastModifiedTimestamp;

  Odds({
    required this.matchWinner,
    required this.overUnder,
    required this.handicap,
    required this.lastModifiedTimestamp,
  });
  @override
  // TODO: implement props
  List<Object?> get props =>
      [overUnder, matchWinner, handicap, lastModifiedTimestamp];
}

class Handicap extends Equatable {
  dynamic market;
  double home;
  double away;

  Handicap({
    required this.market,
    required this.home,
    required this.away,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [home, away, market];
}

class MatchWinner extends Equatable {
  double home;
  double draw;
  double away;

  MatchWinner({
    required this.home,
    required this.draw,
    required this.away,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [home, away, draw];
}

class OverUnder extends Equatable {
  double total;
  double over;
  double under;

  OverUnder({
    required this.total,
    required this.over,
    required this.under,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [total, over, under];
}

class Stadium extends Equatable {
  int id;
  String name;
  String city;

  Stadium({
    required this.id,
    required this.name,
    required this.city,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, city];
}

class Teams extends Equatable {
  TeamResponse home;
  TeamResponse away;

  Teams({
    required this.home,
    required this.away,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [home, away];
}
