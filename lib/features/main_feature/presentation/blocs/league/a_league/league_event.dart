import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';

@immutable
class LeagueEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LeagueFetchedEvent extends LeagueEvent {
  final int leagueId;
  LeagueFetchedEvent(this.leagueId);
  @override
  // TODO: implement props
  List<Object?> get props => [leagueId];
}
