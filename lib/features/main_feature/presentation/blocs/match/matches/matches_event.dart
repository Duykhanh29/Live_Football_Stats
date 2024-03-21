import 'package:equatable/equatable.dart';

class MatchesEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MatchesOfALeagueFetched extends MatchesEvent {
  final int leagueId;
  MatchesOfALeagueFetched(this.leagueId);
  @override
  // TODO: implement props
  List<Object?> get props => [leagueId];
}

class UpcomingMatchesFetched extends MatchesEvent {}
