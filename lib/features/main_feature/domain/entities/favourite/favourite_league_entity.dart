import 'package:hive/hive.dart';

import '../../../../../core/helper/hive_types.dart';

part 'favourite_league_entity.g.dart';

@HiveType(typeId: HiveTypes.favouriteLeagues)
class FavouriteLeagueEntity {
  @HiveField(0)
  String? uid;

  @HiveField(1)
  List<LeagueDataEntity>? leagues;

  FavouriteLeagueEntity({this.uid, this.leagues});
}

@HiveType(typeId: HiveTypes.leagueData)
class LeagueDataEntity {
  @HiveField(0)
  String? leagueID;
  @HiveField(1)
  String? leagueName;
  LeagueDataEntity({this.leagueName, this.leagueID});
}
