// To parse this JSON data, do
//
//     final matchModel = matchModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/data/models/league_model_response.dart';
import 'package:live_football_stats/features/main_feature/data/models/macth_event.dart';
import 'package:live_football_stats/features/main_feature/data/models/player.dart';
import 'package:live_football_stats/features/main_feature/data/models/sidelined_player.dart';
import 'package:live_football_stats/features/main_feature/data/models/stage_model_response.dart';
import 'package:live_football_stats/features/main_feature/data/models/team_model_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart'
    as matchEntity;

MatchModel matchModelFromJson(String str) =>
    MatchModel.fromJson(json.decode(str));

String matchModelToJson(MatchModel data) => json.encode(data.toJson());

class MatchModel {
  int? id;
  String? date;
  String? time;
  CountryModel? country;
  LeagueModelResponse? league;
  StageModelResponse? stage;
  Teams? teams;
  Stadium? stadium;
  MatchStatus? status;
  int? minute;
  Winner? winner;
  bool? hasExtraTime;
  bool? hasPenalties;
  Goals? goals;
  List<MatchEventModel>? events;
  Odds? odds;
  Lineups? lineups;
  MatchPreview? matchPreview;

  MatchModel({
    required this.id,
    required this.date,
    required this.time,
    required this.country,
    required this.league,
    required this.stage,
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

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
        id: json["id"],
        date: json["date"],
        time: json["time"],
        country: CountryModel.fromJson(json["country"]),
        league: LeagueModelResponse.fromJson(json["league"]),
        stage: StageModelResponse.fromJson(json["stage"]),
        teams: Teams.fromJson(json["teams"]),
        stadium: Stadium.fromJson(json["stadium"]),
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
        "country": country?.toJson(),
        "league": league?.toJson(),
        "stage": stage?.toJson(),
        "teams": teams?.toJson(),
        "stadium": stadium?.toJson(),
        "status": matchStatusValues.reverse[status],
        "minute": minute,
        "winner": winnerValues.reverse[winner],
        "has_extra_time": hasExtraTime,
        "has_penalties": hasPenalties,
        "goals": goals?.toJson(),
        "events": events != null
            ? List<dynamic>.from(events!.map((x) => x.toJson()))
            : null,
        "odds": odds?.toJson(),
        "lineups": lineups?.toJson(),
        "match_preview": matchPreview?.toJson(),
      };
  matchEntity.Match toEntity() {
    return matchEntity.Match(
        league: league?.toEntity(),
        stage: stage?.toEntity(),
        country: country?.toEntity(),
        id: id,
        date: date,
        time: time,
        teams: teams?.toEntity(),
        stadium: stadium?.toEntity(),
        status: status,
        minute: minute,
        winner: winner,
        hasExtraTime: hasExtraTime,
        hasPenalties: hasPenalties,
        goals: goals?.toEntity(),
        events: events?.map((e) => e.toEntity()).toList(),
        odds: odds?.toEntity(),
        lineups: lineups?.toEntity(),
        matchPreview: matchPreview?.toEntity());
  }
}

class Goals {
  int? homeHtGoals;
  int? awayHtGoals;
  int? homeFtGoals;
  int? awayFtGoals;
  int? homeEtGoals;
  int? awayEtGoals;
  int? homePenGoals;
  int? awayPenGoals;

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
  matchEntity.Goals toEntity() {
    return matchEntity.Goals(
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
  LineupType? lineupType;
  LineupData? lineups;
  Bench? bench;
  Sidelined? sidelined;
  Formation? formation;

  Lineups({
    required this.lineupType,
    required this.lineups,
    required this.bench,
    required this.sidelined,
    required this.formation,
  });

  factory Lineups.fromJson(Map<String, dynamic> json) => Lineups(
        lineupType: json["lineup_type"] != null
            ? lineupTypeValues.map[json["lineup_type"]]!
            : null,
        lineups: json["lineups"] != null
            ? LineupData.fromJson(json["lineups"])
            : null,
        bench: json["bench"] != null ? Bench.fromJson(json["bench"]) : null,
        sidelined: json["sidelined"] != null
            ? Sidelined.fromJson(json["sidelined"])
            : null,
        formation: json["formation"] != null
            ? Formation.fromJson(json["formation"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "lineup_type": lineupTypeValues.reverse[lineupType],
        "lineups": lineups?.toJson(),
        "bench": bench?.toJson(),
        "sidelined": sidelined?.toJson(),
        "formation": formation?.toJson(),
      };
  matchEntity.Lineups toEntity() {
    return matchEntity.Lineups(
        lineupType: lineupType,
        lineups: lineups?.toEntity(),
        bench: bench?.toEntity(),
        sidelined: sidelined?.toEntity(),
        formation: formation?.toEntity());
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
  matchEntity.LineupData toEntity() {
    return matchEntity.LineupData(
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
  matchEntity.Bench toEntity() {
    return matchEntity.Bench(
        home: home.map((e) => e.toEntity()).toList(),
        away: away.map((e) => e.toEntity()).toList());
  }
}

class BenchAway {
  PlayerModel? player;
  Position? position;

  BenchAway({
    required this.player,
    required this.position,
  });

  factory BenchAway.fromJson(Map<String, dynamic> json) => BenchAway(
        player: PlayerModel.fromJson(json["player"]),
        position: positionValues.map[json["position"]]!,
      );

  Map<String, dynamic> toJson() => {
        "player": player!.toJson(),
        "position": positionValues.reverse[position],
      };
  matchEntity.BenchAway toEntity() {
    return matchEntity.BenchAway(
        player: player!.toEntity(), position: position);
  }
}

class Formation {
  String? home;
  String? away;

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
  matchEntity.Formation toEntity() {
    return matchEntity.Formation(home: home, away: away);
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
  matchEntity.Sidelined toEntity() {
    return matchEntity.Sidelined(
        home: home.map((e) => e.toEntity()).toList(),
        away: away.map((e) => e.toEntity()).toList());
  }
}

class MatchPreview {
  bool? hasPreview;
  int? wordCount;
  double? excitementRating;

  MatchPreview({
    required this.hasPreview,
    required this.wordCount,
    required this.excitementRating,
  });

  factory MatchPreview.fromJson(Map<String, dynamic> json) => MatchPreview(
        hasPreview: json["has_preview"],
        wordCount: json["word_count"],
        excitementRating: json.containsKey('excitement_rating')
            ? json['excitement_rating']
            : null,
      );

  Map<String, dynamic> toJson() => {
        "has_preview": hasPreview,
        "word_count": wordCount,
        "excitement_rating": excitementRating,
      };
  matchEntity.MatchPreview toEntity() {
    return matchEntity.MatchPreview(
        hasPreview: hasPreview,
        wordCount: wordCount,
        excitementRating: excitementRating);
  }
}

class Odds {
  MatchWinner? matchWinner;
  OverUnder? overUnder;
  Handicap? handicap;
  int? lastModifiedTimestamp;

  Odds({
    required this.matchWinner,
    required this.overUnder,
    required this.handicap,
    required this.lastModifiedTimestamp,
  });

  factory Odds.fromJson(Map<String, dynamic> json) {
    return Odds(
      matchWinner: json['match_winner'] != null
          ? MatchWinner.fromJson(json["match_winner"])
          : null,
      overUnder: json['over_under'] != null
          ? OverUnder.fromJson(json["over_under"])
          : null,
      handicap:
          json['handicap'] != null ? Handicap.fromJson(json["handicap"]) : null,
      lastModifiedTimestamp: json.containsKey('last_modified_timestamp')
          ? json['last_modified_timestamp']
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "match_winner": matchWinner?.toJson(),
        "over_under": overUnder?.toJson(),
        "handicap": handicap?.toJson(),
        "last_modified_timestamp": lastModifiedTimestamp,
      };
  matchEntity.Odds toEntity() {
    return matchEntity.Odds(
        matchWinner: matchWinner?.toEntity(),
        overUnder: overUnder?.toEntity(),
        handicap: handicap?.toEntity(),
        lastModifiedTimestamp: lastModifiedTimestamp);
  }
}

class Handicap {
  double? market;
  double? home;
  double? away;

  Handicap({
    required this.market,
    required this.home,
    required this.away,
  });

  factory Handicap.fromJson(Map<String, dynamic> json) {
    var doubleValue = json['example_property'];

    late double marketValue;
    if (doubleValue == null) {
      return Handicap(
        market: null,
        home: json["home"]?.toDouble(),
        away: json["away"]?.toDouble(),
      );
    } else if (doubleValue is String) {
      // Nếu giá trị là một chuỗi, bạn có thể chuyển đổi nó thành double hoặc xử lý nó theo nhu cầu của bạn
      marketValue = double.tryParse(doubleValue) ??
          0.0; // Ví dụ: Chuyển đổi chuỗi thành double
    } else {
      // Nếu giá trị là một số thực, bạn có thể sử dụng trực tiếp
      marketValue = json['example_property'];
    }
    return Handicap(
      market: marketValue,
      home: json["home"]?.toDouble(),
      away: json["away"]?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "market": market,
        "home": home,
        "away": away,
      };
  matchEntity.Handicap toEntity() {
    return matchEntity.Handicap(market: market, home: home, away: away);
  }
}

class MatchWinner {
  double? home;
  double? draw;
  double? away;

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
  matchEntity.MatchWinner toEntity() {
    return matchEntity.MatchWinner(home: home, draw: draw, away: away);
  }
}

class OverUnder {
  double? total;
  double? over;
  double? under;

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
  matchEntity.OverUnder toEntity() {
    return matchEntity.OverUnder(total: total, over: over, under: under);
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
  matchEntity.Stadium toEntity() {
    return matchEntity.Stadium(id: id, name: name, city: city);
  }
}

class Teams {
  TeamModelResponse? home;
  TeamModelResponse? away;

  Teams({
    required this.home,
    required this.away,
  });

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        home: json["home"] != null
            ? TeamModelResponse.fromJson(json["home"])
            : null,
        away: json["away"] != null
            ? TeamModelResponse.fromJson(json["away"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "home": home?.toJson(),
        "away": away?.toJson(),
      };
  matchEntity.Teams toEntity() {
    return matchEntity.Teams(home: home?.toEntity(), away: away?.toEntity());
  }
}
