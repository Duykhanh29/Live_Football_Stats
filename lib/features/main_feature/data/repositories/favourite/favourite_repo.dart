import 'package:dartz/dartz.dart';

import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/favourite/favourite_firestore.dart';
import 'package:live_football_stats/features/main_feature/data/models/favourite/favourite_league_model.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/local/favourite_league_local_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/local/favourite_team_local_data_source.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_league_entity.dart';

import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_team_entity.dart';

import '../../../../../core/platform/network_info.dart';
import '../../../domain/repositories/favourite/favourite_repositories.dart';
import '../../models/favourite/favourite_team_model.dart';

class FavouriteRepoImpl implements FavouriteRepositories {
  FavouriteFirestore favouriteFirestore;
  FavouriteLeagueLocalDataSource favouriteLeagueLocalDataSource;
  FavouriteTeamLocalDataSource favouriteTeamLocalDataSource;
  final NetworkInfo networkInfo;
  FavouriteRepoImpl(
      {required this.favouriteFirestore,
      required this.favouriteLeagueLocalDataSource,
      required this.favouriteTeamLocalDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, bool>?> addFavouriteLeague(
      {required String uid, required LeagueDataModel leagueData}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await favouriteFirestore.addFavouriteLeague(
            leagueData: leagueData, uid: uid);
        await favouriteLeagueLocalDataSource.addFavouriteLeague(
            uid: uid, leagueData: leagueData.toEntity());
        return Right(result);
      }
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>?> addFavouriteTeam(
      {required String uid, required TeamDataModel teamData}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await favouriteFirestore.addFavouriteTeam(
            teamData: teamData, uid: uid);
        await favouriteTeamLocalDataSource.addFavouriteTeam(
            uid: uid, teamData: teamData.toEntity());
        return Right(result);
      }
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>?> deleteAFavouriteLeague(
      {required String uid, required String leagueID}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await favouriteFirestore.deleteFavouriteLeague(
            leagueID: leagueID, uid: uid);
        await favouriteLeagueLocalDataSource.deleteFavouriteLeague(
            uid: uid, leagueID: leagueID);
        return Right(result);
      }
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>?> deleteAFavouriteTeam(
      {required String uid, required String teamID}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await favouriteFirestore.deleteFavouriteTeam(
            teamID: teamID, uid: uid);
        await favouriteTeamLocalDataSource.deleteFavouriteTeam(
            uid: uid, teamID: teamID);
        return Right(result);
      }
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FavouriteLeagueEntity>?> getFavouriteLeagues(
      String uid) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await favouriteFirestore.getFavouriteLeague(uid);
        if (data != null) {
          FavouriteLeagueEntity leagueEntity = data.toEntity();

          return Right(leagueEntity);
        }
      } else {
        final data =
            await favouriteLeagueLocalDataSource.getFavouriteLeague(uid);
        if (data != null) {
          return Right(data);
        }
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FavouriteTeamEntity>?> getFavouriteTeams(
      String uid) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await favouriteFirestore.getFavouriteTeam(uid);
        if (data != null) {
          FavouriteTeamEntity teamEntity = data.toEntity();
          return Right(teamEntity);
        }
      } else {
        final data = await favouriteTeamLocalDataSource.getFavouriteTeam(uid);
        if (data != null) {
          return Right(data);
        }
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
