import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/core/error/failures.dart';

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

class LeaguesOfCountryFetchSuccess extends LeaguesState {
  final List<League> listLeague;
  LeaguesOfCountryFetchSuccess(this.listLeague);
  @override
  // TODO: implement props
  List<Object?> get props => [listLeague];
}

class LeaguesLoading extends LeaguesState {}

class LeaguesFetchFail extends LeaguesState {
  Failure? failure;
  LeaguesFetchFail({this.failure});
  @override
  // TODO: implement props
  List<Object?> get props => [failure];
}
