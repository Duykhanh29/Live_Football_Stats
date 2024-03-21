import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart';
import '../../../../domain/entities/match.dart';

class MatchesState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialMatches extends MatchesState {}

class MatchesFetchSuccess extends MatchesState {
  final LeagueMatches leagueMatches;
  MatchesFetchSuccess(this.leagueMatches);
  @override
  // TODO: implement props
  List<Object?> get props => [leagueMatches];
}

class UpcomingMatchesFetchSucess extends MatchesState {
  final UpcomingMatches upcomingMatches;
  UpcomingMatchesFetchSucess(this.upcomingMatches);
  @override
  // TODO: implement props
  List<Object?> get props => [upcomingMatches];
}

class MatchesLoading extends MatchesState {}

class MatchesFetchFail extends MatchesState {
  String? message;
  MatchesFetchFail({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
