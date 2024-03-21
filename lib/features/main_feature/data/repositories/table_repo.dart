import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/core/platform/network_info.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/table_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/models/stading_model.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/table_repositories.dart';

class TableRepoIplm implements TableRepositories {
  TableRemoteDataSource tableRemoteDataSource;
  NetworkInfo networkInfo;
  TableRepoIplm(
      {required this.networkInfo, required this.tableRemoteDataSource});
  @override
  Future<Either<Failure, StandingEntities>?> getTableByLeagueID(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final StandingModel? standingModel =
            await tableRemoteDataSource.getTableByLeague(id);
        if (standingModel != null) {
          StandingEntities standingEntities = standingModel.toEntity();
          return Right(standingEntities);
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
