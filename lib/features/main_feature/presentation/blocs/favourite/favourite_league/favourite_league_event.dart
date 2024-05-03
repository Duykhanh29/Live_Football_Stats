import 'package:equatable/equatable.dart';

import '../../../../data/models/favourite/favourite_league_model.dart';

class FavouriteLeagueEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddFavouriteLeague extends FavouriteLeagueEvent {
  String uid;
  LeagueDataModel leagueData;
  AddFavouriteLeague({required this.leagueData, required this.uid});
  @override
  // TODO: implement props
  List<Object?> get props => [uid, leagueData];
}

class DeleteFavouriteLeague extends FavouriteLeagueEvent {
  String uid, leagueID;
  DeleteFavouriteLeague({required this.leagueID, required this.uid});
  @override
  // TODO: implement props
  List<Object?> get props => [uid, leagueID];
}

class FecthFavouriteLeagues extends FavouriteLeagueEvent {
  String uid;
  FecthFavouriteLeagues({required this.uid});
  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
