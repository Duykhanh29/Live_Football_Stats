import 'package:equatable/equatable.dart';

class MatchEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MatchFetched extends MatchEvent {
  final int matchId;
  MatchFetched(this.matchId);
  @override
  // TODO: implement props
  List<Object?> get props => [matchId];
}

class MatchPriviewFetched extends MatchEvent {
  final int matchId;
  MatchPriviewFetched(this.matchId);
  @override
  // TODO: implement props
  List<Object?> get props => [matchId];
}
