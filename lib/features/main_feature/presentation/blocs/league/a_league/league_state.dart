import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/core/error/failures.dart';

@immutable
class LeagueState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class IntialLeague extends LeagueState {}

class LeagueFetchSuccess extends LeagueState {
  final League? league;
  LeagueFetchSuccess(this.league);
  @override
  // TODO: implement props
  List<Object?> get props => [league];
}

class LeagueLoading extends LeagueState {}

class LeagueFetchFail extends LeagueState {
  Failure? failure;
  LeagueFetchFail({this.failure});
  @override
  // TODO: implement props
  List<Object?> get props => [failure];
}
