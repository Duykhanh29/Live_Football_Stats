import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_football_stats/core/constants/string_constants.dart';

import '../../../domain/entities/favourite/favourite_team_entity.dart';

abstract class FavouriteTeamLocalDataSource {
  Future<FavouriteTeamEntity?> getFavouriteTeam(String uid);

  Future<bool> addFavouriteTeam(
      {required String uid, required TeamDataEntity teamData});

  Future<bool> deleteFavouriteTeam(
      {required String uid, required String teamID});
}

class FavouriteTeamLocalDataSourceImpl implements FavouriteTeamLocalDataSource {
  FavouriteTeamLocalDataSourceImpl();
  @override
  Future<bool> addFavouriteTeam(
      {required String uid, required TeamDataEntity teamData}) async {
    final Box box = await Hive.openBox<FavouriteTeamEntity>(
        StringConstants.favouriteTeamKey);

    if (box.isEmpty) {
      FavouriteTeamEntity favouriteLeagueEntity =
          FavouriteTeamEntity(teams: [teamData], uid: uid);
      await box.put(StringConstants.favouriteTeam, favouriteLeagueEntity);
      return true;
    } else {
      FavouriteTeamEntity? data = box.get(StringConstants.favouriteTeam);
      if (data != null) {
        data.teams!.add(teamData);
        await box.put(StringConstants.favouriteTeam, data);
        return true;
      }
      return false;
    }
  }

  @override
  Future<bool> deleteFavouriteTeam(
      {required String uid, required String teamID}) async {
    final Box box = await Hive.openBox<FavouriteTeamEntity>(
        StringConstants.favouriteTeamKey);
    FavouriteTeamEntity? data = box.get(StringConstants.favouriteTeam);
    if (data != null) {
      data.teams!.removeWhere((element) => element.teamID == teamID);
      await box.put(StringConstants.favouriteTeam, data);
      return true;
    }
    return false;
  }

  @override
  Future<FavouriteTeamEntity?> getFavouriteTeam(String uid) async {
    final Box box = await Hive.openBox<FavouriteTeamEntity>(
        StringConstants.favouriteTeamKey);
    FavouriteTeamEntity? data = box.get(StringConstants.favouriteTeam);
    return data;
  }
}
