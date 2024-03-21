// To parse this JSON data, do
//
//     final sidelinedPlayer = sidelinedPlayerFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';

class SidelinedPlayer extends Equatable {
  Player? player;
  String? status;
  String? desc;

  SidelinedPlayer({
    required this.player,
    required this.status,
    required this.desc,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [player, desc, status];
}
