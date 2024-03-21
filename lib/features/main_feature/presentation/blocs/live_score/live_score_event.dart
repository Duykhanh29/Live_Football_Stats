import 'package:equatable/equatable.dart';

class LiveScoreEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LiveScoreFetched extends LiveScoreEvent {}

class LiveMatchFetched extends LiveScoreEvent {
  int leagueID, stageID, matchID;
  LiveMatchFetched(
      {required this.leagueID, required this.matchID, required this.stageID});
  @override
  // TODO: implement props
  List<Object?> get props => [leagueID, stageID, matchID];
}
