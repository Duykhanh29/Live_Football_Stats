import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';

import '../../../data/models/favourite/favourite_league_model.dart';
import '../../../data/models/favourite/favourite_team_model.dart';
import '../../entities/favourite/favourite_league_entity.dart';
import '../../entities/favourite/favourite_team_entity.dart';

abstract class FavouriteRepositories {
  Future<Either<Failure, FavouriteLeagueEntity>?> getFavouriteLeagues(
      String uid);
  Future<Either<Failure, FavouriteTeamEntity>?> getFavouriteTeams(String uid);
  Future<Either<Failure, bool>?> addFavouriteLeague(
      {required String uid, required LeagueDataModel leagueData});
  Future<Either<Failure, bool>?> addFavouriteTeam(
      {required String uid, required TeamDataModel teamData});
  Future<Either<Failure, bool>?> deleteAFavouriteLeague(
      {required String uid, required String leagueID});
  Future<Either<Failure, bool>?> deleteAFavouriteTeam(
      {required String uid, required String teamID});
}
