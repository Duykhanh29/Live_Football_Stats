import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart';

class UpcomingMatchesState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialUpcomingMatches extends UpcomingMatchesState {}

class UpcomingMatchesFetchSuccess extends UpcomingMatchesState {
  final UpcomingMatches upcomingMatches;
  UpcomingMatchesFetchSuccess(this.upcomingMatches);
  @override
  // TODO: implement props
  List<Object?> get props => [upcomingMatches];
}

class UpcomingMatchesLoading extends UpcomingMatchesState {}

// ignore: must_be_immutable
class UpcomingMatchesFetchFail extends UpcomingMatchesState {
  String? message;
  UpcomingMatchesFetchFail({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
