import 'package:hive/hive.dart';

import '../../../../../core/helper/hive_types.dart';

part 'favourite_team_entity.g.dart';

@HiveType(typeId: HiveTypes.favouriteTeams)
class FavouriteTeamEntity {
  @HiveField(0)
  String? uid;
  @HiveField(1)
  List<TeamDataEntity>? teams;
  FavouriteTeamEntity({this.uid, this.teams});
}

@HiveType(typeId: HiveTypes.teamData)
class TeamDataEntity {
  @HiveField(0)
  String? teamID;
  @HiveField(1)
  String? teamName;
  TeamDataEntity({this.teamID, this.teamName});
}
