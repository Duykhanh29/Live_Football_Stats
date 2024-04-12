import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';

import '../../../../../../core/error/failures.dart';

class TeamState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TeamInitial extends TeamState {}

class TeamLoading extends TeamState {}

class TeamFetchSuccess extends TeamState {
  Team team;
  TeamFetchSuccess({required this.team});
  @override
  // TODO: implement props
  List<Object?> get props => [team];
}

class TeamFetchFail extends TeamState {
  Failure? failure;
  TeamFetchFail({this.failure});
  @override
  // TODO: implement props
  List<Object?> get props => [failure];
}
