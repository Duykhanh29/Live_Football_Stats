import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_league_entity.dart';

class FavouriteLeagueState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialFavouriteLeague extends FavouriteLeagueState {}

class LoadingFavouriteLeague extends FavouriteLeagueState {}

class FavouriteLeagueFetchedSucess extends FavouriteLeagueState {
  FavouriteLeagueEntity favouriteLeague;
  FavouriteLeagueFetchedSucess({required this.favouriteLeague});
  @override
  // TODO: implement props
  List<Object?> get props => [favouriteLeague];
}

class FavouriteLeagueFetchedFail extends FavouriteLeagueState {
  String? message;
  FavouriteLeagueFetchedFail({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class FavouriteLeagueFailWithNoInternet extends FavouriteLeagueState {
  String? message;
  FavouriteLeagueFailWithNoInternet({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
