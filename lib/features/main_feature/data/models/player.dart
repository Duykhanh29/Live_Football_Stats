// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

import 'dart:convert';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';

PlayerModel playerFromJson(String str) =>
    PlayerModel.fromJson(json.decode(str));

String playerToJson(PlayerModel data) => json.encode(data.toJson());

class PlayerModel {
  int? id;
  String? name;

  PlayerModel({
    required this.id,
    required this.name,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  Player toEntity() {
    return Player(id: id, name: name);
  }
}
