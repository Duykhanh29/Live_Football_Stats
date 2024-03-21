// To parse this JSON data, do
//
//     final matchEvent = matchEventFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/data/models/player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_event.dart';

MatchEventModel matchEventFromJson(String str) =>
    MatchEventModel.fromJson(json.decode(str));

String matchEventToJson(MatchEventModel data) => json.encode(data.toJson());

class MatchEventModel {
  EventType? eventType;
  String? eventMinute;
  EventTeam? team;
  PlayerModel? player;
  PlayerModel? assistPlayer;
  PlayerModel? playerIn;
  PlayerModel? playerOut;

  MatchEventModel(
      {required this.eventType,
      required this.eventMinute,
      required this.team,
      required this.player,
      required this.assistPlayer,
      this.playerIn,
      this.playerOut});

  factory MatchEventModel.fromJson(Map<String, dynamic> json) =>
      MatchEventModel(
        eventType: json["event_type"] != null
            ? eventTypeValues.map[json["event_type"]]
            : null,
        eventMinute: json["event_minute"],
        team: json["team"] != null ? eventTeam.map[json["team"]] : null,
        player: json["player"] != null
            ? PlayerModel.fromJson(json["player"])
            : null,
        assistPlayer: json["assist_player"] != null
            ? PlayerModel.fromJson(json["assist_player"])
            : null,
        playerIn: json["player_in"] != null
            ? PlayerModel.fromJson(json['player_in'])
            : null,
        playerOut: json["player_out"] != null
            ? PlayerModel.fromJson(json['player_out'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "event_type": eventTypeValues.reverse[eventType],
        "event_minute": eventMinute,
        "team": eventTeam.reverse[team],
        "player": player?.toJson(),
        "assist_player": assistPlayer,
        // ignore: prefer_null_aware_operators
        "playerOut": playerOut != null ? playerOut!.toJson() : null,
        // ignore: prefer_null_aware_operators
        "playerIn": playerIn != null ? playerIn!.toJson() : null,
      };
  MatchEvent toEntity() {
    return MatchEvent(
        eventType: eventType,
        eventMinute: eventMinute,
        team: team,
        player: player?.toEntity(),
        assistPlayer: assistPlayer?.toEntity(),
        playerIn: playerIn?.toEntity(),
        playerOut: playerOut?.toEntity());
  }
}
