// To parse this JSON data, do
//
//     final sidelinedPlayer = sidelinedPlayerFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/features/main_feature/data/models/player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/sidelined_player.dart';

SidelinedPlayerModel sidelinedPlayerFromJson(String str) =>
    SidelinedPlayerModel.fromJson(json.decode(str));

String sidelinedPlayerToJson(SidelinedPlayerModel data) =>
    json.encode(data.toJson());

class SidelinedPlayerModel {
  PlayerModel? player;
  String? status;
  String? desc;

  SidelinedPlayerModel({
    required this.player,
    required this.status,
    required this.desc,
  });

  factory SidelinedPlayerModel.fromJson(Map<String, dynamic> json) =>
      SidelinedPlayerModel(
        player: json["player"] != null
            ? PlayerModel.fromJson(json["player"])
            : null,
        status: json["status"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "player": player?.toJson(),
        "status": status,
        "desc": desc,
      };
  SidelinedPlayer toEntity() {
    return SidelinedPlayer(
        player: player?.toEntity(), status: status, desc: desc);
  }
}
