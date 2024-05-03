import 'package:equatable/equatable.dart';

import '../../../../data/models/favourite/favourite_team_model.dart';

class FavouriteTeamEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddFavouriteTeam extends FavouriteTeamEvent {
  String uid;
  TeamDataModel teamData;
  AddFavouriteTeam({required this.teamData, required this.uid});
  @override
  // TODO: implement props
  List<Object?> get props => [uid, teamData];
}

class DeleteFavouriteTeam extends FavouriteTeamEvent {
  String uid, teamID;
  DeleteFavouriteTeam({required this.teamID, required this.uid});
  @override
  // TODO: implement props
  List<Object?> get props => [uid, teamID];
}

class FecthFavouriteTeams extends FavouriteTeamEvent {
  String uid;
  FecthFavouriteTeams({required this.uid});
  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
