import 'package:equatable/equatable.dart';

class TeamEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TeamFetched extends TeamEvent {
  int teamID;
  TeamFetched({required this.teamID});
  @override
  // TODO: implement props
  List<Object?> get props => [teamID];
}
