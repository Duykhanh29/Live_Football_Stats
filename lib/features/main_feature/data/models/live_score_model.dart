// To parse this JSON data, do
//
//     final liveScoreModel = liveScoreModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/data/models/macth_event.dart';
import 'package:live_football_stats/features/main_feature/data/models/player.dart';
import 'package:live_football_stats/features/main_feature/data/models/sidelined_player.dart';
import 'package:live_football_stats/features/main_feature/data/models/team_model_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart'
    as liveScoreEntity;

List<LiveScoreModel> liveScoreModelFromJson(String str) =>
    List<LiveScoreModel>.from(
        json.decode(str).map((x) => LiveScoreModel.fromJson(x)));

String liveScoreModelToJson(List<LiveScoreModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveScoreModel {
  int leagueId;
  String leagueName;
  CountryModel country;
  bool isCup;
  List<Stage> stage;

  LiveScoreModel({
    required this.leagueId,
    required this.leagueName,
    required this.country,
    required this.isCup,
    required this.stage,
  });

  factory LiveScoreModel.fromJson(Map<String, dynamic> json) => LiveScoreModel(
        leagueId: json["league_id"],
        leagueName: json["league_name"],
        country: CountryModel.fromJson(json["country"]),
        isCup: json["is_cup"],
        stage: List<Stage>.from(json["stage"].map((x) => Stage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "league_id": leagueId,
        "league_name": leagueName,
        "country": country.toJson(),
        "is_cup": isCup,
        "stage": List<dynamic>.from(stage.map((x) => x.toJson())),
      };
  liveScoreEntity.LiveScore toEntity() {
    return liveScoreEntity.LiveScore(
        leagueId: leagueId,
        leagueName: leagueName,
        country: country.toEntity(),
        isCup: isCup,
        stage: stage.map((e) => e.toEntity()).toList());
  }
}

class Stage {
  int stageId;
  String stageName;
  List<Match> matches;

  Stage({
    required this.stageId,
    required this.stageName,
    required this.matches,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        stageId: json["stage_id"],
        stageName: json["stage_name"],
        matches:
            List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stage_id": stageId,
        "stage_name": stageName,
        "matches": List<dynamic>.from(matches.map((x) => x.toJson())),
      };
  liveScoreEntity.Stage toEntity() {
    return liveScoreEntity.Stage(
        stageId: stageId,
        stageName: stageName,
        matches: matches.map((e) => e.toEntity()).toList());
  }
}

class Match {
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
  List<MatchEventModel> events;
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

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["id"],
        date: json["date"],
        time: json["time"],
        teams: Teams.fromJson(json["teams"]),
        stadium:
            json["stadium"] == null ? null : Stadium.fromJson(json["stadium"]),
        status: matchStatusValues.map[json["status"]]!,
        minute: json["minute"],
        winner: winnerValues.map[json["winner"]]!,
        hasExtraTime: json["has_extra_time"],
        hasPenalties: json["has_penalties"],
        goals: Goals.fromJson(json["goals"]),
        events: List<MatchEventModel>.from(
            json["events"].map((x) => MatchEventModel.fromJson(x))),
        odds: Odds.fromJson(json["odds"]),
        lineups: Lineups.fromJson(json["lineups"]),
        matchPreview: MatchPreview.fromJson(json["match_preview"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "time": time,
        "teams": teams.toJson(),
        "stadium": stadium?.toJson(),
        "status": matchStatusValues.reverse[status],
        "minute": minute,
        "winner": winnerValues.reverse[winner],
        "has_extra_time": hasExtraTime,
        "has_penalties": hasPenalties,
        "goals": goals.toJson(),
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
        "odds": odds.toJson(),
        "lineups": lineups.toJson(),
        "match_preview": matchPreview.toJson(),
      };
  liveScoreEntity.Match toEntity() {
    return liveScoreEntity.Match(
        id: id,
        date: date,
        time: time,
        teams: teams.toEntity(),
        stadium: stadium != null ? stadium!.toEntity() : null,
        status: status,
        minute: minute,
        winner: winner,
        hasExtraTime: hasExtraTime,
        hasPenalties: hasPenalties,
        goals: goals.toEntity(),
        events: events.map((e) => e.toEntity()).toList(),
        odds: odds.toEntity(),
        lineups: lineups.toEntity(),
        matchPreview: matchPreview.toEntity());
  }
}

class Goals {
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

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
        homeHtGoals: json["home_ht_goals"],
        awayHtGoals: json["away_ht_goals"],
        homeFtGoals: json["home_ft_goals"],
        awayFtGoals: json["away_ft_goals"],
        homeEtGoals: json["home_et_goals"],
        awayEtGoals: json["away_et_goals"],
        homePenGoals: json["home_pen_goals"],
        awayPenGoals: json["away_pen_goals"],
      );

  Map<String, dynamic> toJson() => {
        "home_ht_goals": homeHtGoals,
        "away_ht_goals": awayHtGoals,
        "home_ft_goals": homeFtGoals,
        "away_ft_goals": awayFtGoals,
        "home_et_goals": homeEtGoals,
        "away_et_goals": awayEtGoals,
        "home_pen_goals": homePenGoals,
        "away_pen_goals": awayPenGoals,
      };
  liveScoreEntity.Goals toEntity() {
    return liveScoreEntity.Goals(
        homeHtGoals: homeHtGoals,
        awayHtGoals: awayHtGoals,
        homeFtGoals: homeFtGoals,
        awayFtGoals: awayFtGoals,
        homeEtGoals: homeEtGoals,
        awayEtGoals: awayEtGoals,
        homePenGoals: homePenGoals,
        awayPenGoals: awayPenGoals);
  }
}

class Lineups {
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

  factory Lineups.fromJson(Map<String, dynamic> json) => Lineups(
        lineupType: lineupTypeValues.map[json["lineup_type"]]!,
        lineups: LineupData.fromJson(json["lineups"]),
        bench: Bench.fromJson(json["bench"]),
        sidelined: Sidelined.fromJson(json["sidelined"]),
        formation: Formation.fromJson(json["formation"]),
      );

  Map<String, dynamic> toJson() => {
        "lineup_type": lineupTypeValues.reverse[lineupType],
        "lineups": lineups.toJson(),
        "bench": bench.toJson(),
        "sidelined": sidelined.toJson(),
        "formation": formation.toJson(),
      };
  liveScoreEntity.Lineups toEntity() {
    return liveScoreEntity.Lineups(
        lineupType: lineupType,
        lineups: lineups.toEntity(),
        bench: bench.toEntity(),
        sidelined: sidelined.toEntity(),
        formation: formation.toEntity());
  }
}

class LineupData {
  List<BenchAway> home;
  List<BenchAway> away;

  LineupData({
    required this.home,
    required this.away,
  });

  factory LineupData.fromJson(Map<String, dynamic> json) => LineupData(
        home: List<BenchAway>.from(
            json["home"].map((x) => BenchAway.fromJson(x))),
        away: List<BenchAway>.from(
            json["away"].map((x) => BenchAway.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home": List<dynamic>.from(home.map((x) => x.toJson())),
        "away": List<dynamic>.from(away.map((x) => x.toJson())),
      };
  liveScoreEntity.LineupData toEntity() {
    return liveScoreEntity.LineupData(
        home: home.map((e) => e.toEntity()).toList(),
        away: away.map((e) => e.toEntity()).toList());
  }
}

class Bench {
  List<BenchAway> home;
  List<BenchAway> away;

  Bench({
    required this.home,
    required this.away,
  });

  factory Bench.fromJson(Map<String, dynamic> json) => Bench(
        home: List<BenchAway>.from(
            json["home"].map((x) => BenchAway.fromJson(x))),
        away: List<BenchAway>.from(
            json["away"].map((x) => BenchAway.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home": List<dynamic>.from(home.map((x) => x.toJson())),
        "away": List<dynamic>.from(away.map((x) => x.toJson())),
      };
  liveScoreEntity.Bench toEntity() {
    return liveScoreEntity.Bench(
        home: home.map((e) => e.toEntity()).toList(),
        away: away.map((e) => e.toEntity()).toList());
  }
}

class BenchAway {
  PlayerModel player;
  Position position;

  BenchAway({
    required this.player,
    required this.position,
  });

  factory BenchAway.fromJson(Map<String, dynamic> json) => BenchAway(
        player: PlayerModel.fromJson(json["player"]),
        position: positionValues.map[json["position"]]!,
      );

  Map<String, dynamic> toJson() => {
        "player": player.toJson(),
        "position": positionValues.reverse[position],
      };
  liveScoreEntity.BenchAway toEntity() {
    return liveScoreEntity.BenchAway(
        player: player.toEntity(), position: position);
  }
}

class Formation {
  String home;
  String away;

  Formation({
    required this.home,
    required this.away,
  });

  factory Formation.fromJson(Map<String, dynamic> json) => Formation(
        home: json["home"],
        away: json["away"],
      );

  Map<String, dynamic> toJson() => {
        "home": home,
        "away": away,
      };
  liveScoreEntity.Formation toEntity() {
    return liveScoreEntity.Formation(home: home, away: away);
  }
}

class Sidelined {
  List<SidelinedPlayerModel> home;
  List<SidelinedPlayerModel> away;

  Sidelined({
    required this.home,
    required this.away,
  });

  factory Sidelined.fromJson(Map<String, dynamic> json) => Sidelined(
        home: List<SidelinedPlayerModel>.from(
            json["home"].map((x) => SidelinedPlayerModel.fromJson(x))),
        away: List<SidelinedPlayerModel>.from(
            json["away"].map((x) => SidelinedPlayerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home": List<dynamic>.from(home.map((x) => x.toJson())),
        "away": List<dynamic>.from(away.map((x) => x.toJson())),
      };
  liveScoreEntity.Sidelined toEntity() {
    return liveScoreEntity.Sidelined(
        home: home.map((e) => e.toEntity()).toList(),
        away: away.map((e) => e.toEntity()).toList());
  }
}

class MatchPreview {
  bool hasPreview;
  int wordCount;
  double? excitementRating;

  MatchPreview({
    required this.hasPreview,
    required this.wordCount,
    this.excitementRating,
  });

  factory MatchPreview.fromJson(Map<String, dynamic> json) => MatchPreview(
        hasPreview: json["has_preview"],
        wordCount: json["word_count"],
        excitementRating: json["excitement_rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "has_preview": hasPreview,
        "word_count": wordCount,
        "excitement_rating": excitementRating,
      };
  liveScoreEntity.MatchPreview toEntity() {
    return liveScoreEntity.MatchPreview(
        hasPreview: hasPreview,
        wordCount: wordCount,
        excitementRating: excitementRating);
  }
}

class Odds {
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

  factory Odds.fromJson(Map<String, dynamic> json) => Odds(
        matchWinner: MatchWinner.fromJson(json["match_winner"]),
        overUnder: OverUnder.fromJson(json["over_under"]),
        handicap: Handicap.fromJson(json["handicap"]),
        lastModifiedTimestamp: json["last_modified_timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "match_winner": matchWinner.toJson(),
        "over_under": overUnder.toJson(),
        "handicap": handicap.toJson(),
        "last_modified_timestamp": lastModifiedTimestamp,
      };
  liveScoreEntity.Odds toEntity() {
    return liveScoreEntity.Odds(
        matchWinner: matchWinner.toEntity(),
        overUnder: overUnder.toEntity(),
        handicap: handicap.toEntity(),
        lastModifiedTimestamp: lastModifiedTimestamp);
  }
}

class Handicap {
  dynamic market;
  double home;
  double away;

  Handicap({
    required this.market,
    required this.home,
    required this.away,
  });

  factory Handicap.fromJson(Map<String, dynamic> json) => Handicap(
        market: json["market"],
        home: json["home"]?.toDouble(),
        away: json["away"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "market": market,
        "home": home,
        "away": away,
      };
  liveScoreEntity.Handicap toEntity() {
    return liveScoreEntity.Handicap(market: market, home: home, away: away);
  }
}

class MatchWinner {
  double home;
  double draw;
  double away;

  MatchWinner({
    required this.home,
    required this.draw,
    required this.away,
  });

  factory MatchWinner.fromJson(Map<String, dynamic> json) => MatchWinner(
        home: json["home"]?.toDouble(),
        draw: json["draw"]?.toDouble(),
        away: json["away"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "home": home,
        "draw": draw,
        "away": away,
      };
  liveScoreEntity.MatchWinner toEntity() {
    return liveScoreEntity.MatchWinner(home: home, draw: draw, away: away);
  }
}

class OverUnder {
  double total;
  double over;
  double under;

  OverUnder({
    required this.total,
    required this.over,
    required this.under,
  });

  factory OverUnder.fromJson(Map<String, dynamic> json) => OverUnder(
        total: json["total"]?.toDouble(),
        over: json["over"]?.toDouble(),
        under: json["under"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "over": over,
        "under": under,
      };
  liveScoreEntity.OverUnder toEntity() {
    return liveScoreEntity.OverUnder(total: total, over: over, under: under);
  }
}

class Stadium {
  int id;
  String name;
  String city;

  Stadium({
    required this.id,
    required this.name,
    required this.city,
  });

  factory Stadium.fromJson(Map<String, dynamic> json) => Stadium(
        id: json["id"],
        name: json["name"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
      };
  liveScoreEntity.Stadium toEntity() {
    return liveScoreEntity.Stadium(id: id, name: name, city: city);
  }
}

class Teams {
  TeamModelResponse home;
  TeamModelResponse away;

  Teams({
    required this.home,
    required this.away,
  });

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        home: TeamModelResponse.fromJson(json["home"]),
        away: TeamModelResponse.fromJson(json["away"]),
      );

  Map<String, dynamic> toJson() => {
        "home": home.toJson(),
        "away": away.toJson(),
      };
  liveScoreEntity.Teams toEntity() {
    return liveScoreEntity.Teams(home: home.toEntity(), away: away.toEntity());
  }
}
