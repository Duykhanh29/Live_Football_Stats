import 'package:equatable/equatable.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';

class MatchEvent extends Equatable {
  EventType? eventType;
  String? eventMinute;
  EventTeam? team;
  Player? player;
  Player? assistPlayer;
  Player? playerIn;
  Player? playerOut;

  MatchEvent(
      {required this.eventType,
      required this.eventMinute,
      required this.team,
      required this.player,
      required this.assistPlayer,
      this.playerIn,
      this.playerOut});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [eventMinute, eventType, team, player, playerIn, playerOut, assistPlayer];
}
