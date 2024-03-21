import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/core/platform/network_info.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/team_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/models/player.dart';
import 'package:live_football_stats/features/main_feature/data/models/stadium.dart';
import 'package:live_football_stats/features/main_feature/data/models/team.dart';
import 'package:live_football_stats/features/main_feature/data/models/transfer_model.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/transfer.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stadium.dart'
    as stadiumEntity;

class TeamRepoImpl implements TeamRepositories {
  TeamRemoteDataSource teamRemoteDataSource;
  NetworkInfo networkInfo;
  TeamRepoImpl({required this.networkInfo, required this.teamRemoteDataSource});
  @override
  Future<Either<Failure, Player>?> getPlayerByID(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final PlayerModel? playerModel =
            await teamRemoteDataSource.getPlayerByID(id);
        if (playerModel != null) {
          Player player = playerModel.toEntity();
          return Right(player);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, stadiumEntity.Stadium>?> getStadiumByID(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final StadiumModel? stadiumModel =
            await teamRemoteDataSource.getStadiumByID(id);
        if (stadiumModel != null) {
          stadiumEntity.Stadium stadium = stadiumModel.toEntity();
          return Right(stadium);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Team>?> getTeamByID(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final TeamModel? teamModel = await teamRemoteDataSource.getTeamByID(id);
        if (teamModel != null) {
          Team team = teamModel.toEntity();
          return Right(team);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Transfer>?> getTransferByTeamID(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final TransferModel? transferModel =
            await teamRemoteDataSource.getTransferByID(id);
        if (transferModel != null) {
          Transfer transfer = transferModel.toEntity();
          return Right(transfer);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
