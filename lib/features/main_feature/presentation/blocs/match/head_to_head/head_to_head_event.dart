import 'package:equatable/equatable.dart';

class HeadToHeadEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HeadToHeadFetched extends HeadToHeadEvent {
  int team1ID, team2ID;
  HeadToHeadFetched({required this.team1ID, required this.team2ID});
  @override
  // TODO: implement props
  List<Object?> get props => [team1ID, team2ID];
}
