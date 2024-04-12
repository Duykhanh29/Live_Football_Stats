import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart'
    as preview;

@immutable
class MatchState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialMatch extends MatchState {}

class MatchFetchSuccess extends MatchState {
  final Match? match;
  MatchFetchSuccess(this.match);
  @override
  // TODO: implement props
  List<Object?> get props => [match];
}

class MatchLoading extends MatchState {}

class MatchFetchFail extends MatchState {
  Failure? failure;
  MatchFetchFail({this.failure});
  @override
  // TODO: implement props
  List<Object?> get props => [failure];
}
