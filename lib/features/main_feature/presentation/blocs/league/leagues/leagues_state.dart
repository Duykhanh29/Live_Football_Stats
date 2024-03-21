import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';

class LeaguesState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialLeagues extends LeaguesState {}

class LeaguesFetchSuccess extends LeaguesState {
  final List<League> listLeague;
  LeaguesFetchSuccess(this.listLeague);
  @override
  // TODO: implement props
  List<Object?> get props => [listLeague];
}

class LeaguesLoading extends LeaguesState {}

class LeaguesFetchFail extends LeaguesState {
  String? message;
  LeaguesFetchFail({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
