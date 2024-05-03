import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_football_stats/core/constants/string_constants.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_league_entity.dart';

abstract class FavouriteLeagueLocalDataSource {
  Future<FavouriteLeagueEntity?> getFavouriteLeague(String uid);

  Future<bool> addFavouriteLeague(
      {required String uid, required LeagueDataEntity leagueData});

  Future<bool> deleteFavouriteLeague(
      {required String uid, required String leagueID});
}

class FavouriteLeagueLocalDataSourceImpl
    implements FavouriteLeagueLocalDataSource {
  FavouriteLeagueLocalDataSourceImpl();
  @override
  Future<bool> addFavouriteLeague(
      {required String uid, required LeagueDataEntity leagueData}) async {
    final Box box = await Hive.openBox<FavouriteLeagueEntity>(
        StringConstants.favouriteLeagueKey);

    if (box.isEmpty) {
      FavouriteLeagueEntity favouriteLeagueEntity =
          FavouriteLeagueEntity(leagues: [leagueData], uid: uid);
      await box.put(StringConstants.favouriteLeague, favouriteLeagueEntity);
      return true;
    } else {
      FavouriteLeagueEntity? data = box.get(StringConstants.favouriteLeague);
      if (data != null) {
        data.leagues!.add(leagueData);
        await box.put(StringConstants.favouriteLeague, data);
        return true;
      }
      return false;
    }
  }

  @override
  Future<bool> deleteFavouriteLeague(
      {required String uid, required String leagueID}) async {
    final Box box = await Hive.openBox<FavouriteLeagueEntity>(
        StringConstants.favouriteLeagueKey);
    FavouriteLeagueEntity? data = box.get(StringConstants.favouriteLeague);
    if (data != null) {
      data.leagues!.removeWhere((element) => element.leagueID == leagueID);
      await box.put(StringConstants.favouriteLeague, data);
      return true;
    }
    return false;
  }

  @override
  Future<FavouriteLeagueEntity?> getFavouriteLeague(String uid) async {
    final Box box = await Hive.openBox<FavouriteLeagueEntity>(
        StringConstants.favouriteLeagueKey);
    FavouriteLeagueEntity? data = box.get(StringConstants.favouriteLeague);
    return data;
  }
}
