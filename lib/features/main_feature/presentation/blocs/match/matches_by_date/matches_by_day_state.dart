import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart';
import '../../../../domain/entities/match.dart';

class MatchesByDateState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialMatchesByDate extends MatchesByDateState {}

class MatchesByDateFetchSuccess extends MatchesByDateState {
  final List<LeagueMatches> listLeagueMatches;
  MatchesByDateFetchSuccess(this.listLeagueMatches);
  @override
  // TODO: implement props
  List<Object?> get props => [listLeagueMatches];
}

class MatchesByDateLoading extends MatchesByDateState {}

class MatchesByDateFetchFail extends MatchesByDateState {
  String? message;
  MatchesByDateFetchFail({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
