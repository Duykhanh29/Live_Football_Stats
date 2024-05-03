import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_league_entity.dart';

import '../../../../domain/entities/favourite/favourite_team_entity.dart';

class FavouriteTeamState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialFavouriteTeam extends FavouriteTeamState {}

class LoadingFavouriteTeam extends FavouriteTeamState {}

class FavouriteTeamFetchedSucess extends FavouriteTeamState {
  FavouriteTeamEntity favouriteTeam;
  FavouriteTeamFetchedSucess({required this.favouriteTeam});
  @override
  // TODO: implement props
  List<Object?> get props => [favouriteTeam];
}

class FavouriteTeamFetchedFail extends FavouriteTeamState {
  String? message;
  FavouriteTeamFetchedFail({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class FavouriteTeamFailWithNoInternet extends FavouriteTeamState {
  String? message;
  FavouriteTeamFailWithNoInternet({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
