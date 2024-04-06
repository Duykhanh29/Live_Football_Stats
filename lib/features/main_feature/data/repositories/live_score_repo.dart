import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/core/platform/network_info.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/live_score_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/live_score_repositories.dart';
import 'package:live_football_stats/features/main_feature/data/models/live_score_model.dart'
    as model;

class LiveScoreRepoImpl implements LiveScoreRepositories {
  LiveScoreRemoteDataSource liveScoreRemoteDataSource;
  NetworkInfo networkInfo;
  LiveScoreRepoImpl(
      {required this.liveScoreRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Match>>?> getListLiveMatchesOfAStage(
      int leagueID, int stageID) async {
    if (await networkInfo.isConnected) {
      try {
        final List<model.Match>? listMatch = await liveScoreRemoteDataSource
            .getListLiveMatchesOfAStage(leagueID, stageID);
        if (listMatch != null) {
          final List<Match> list = listMatch.map((e) => e.toEntity()).toList();
          return Right(list);
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
  Future<Either<Failure, List<Stage>>?> getListStage(int leagueID) async {
    if (await networkInfo.isConnected) {
      try {
        final List<model.Stage>? listMatch =
            await liveScoreRemoteDataSource.getLiveStages(leagueID);
        if (listMatch != null) {
          final List<Stage> list = listMatch.map((e) => e.toEntity()).toList();
          return Right(list);
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
  Future<Either<Failure, Match>?> getLiveMatchByID(
      int leagueID, int stageID, int matchID) async {
    if (await networkInfo.isConnected) {
      try {
        final model.Match? matchModel = await liveScoreRemoteDataSource
            .getLiveMatch(leagueID, stageID, matchID);
        if (matchModel != null) {
          final Match match = matchModel.toEntity();
          return Right(match);
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
  Future<Either<Failure, List<LiveScore>>?> getLiveScore() async {
    if (await networkInfo.isConnected) {
      try {
        final List<model.LiveScoreModel>? liveScoreModel =
            await liveScoreRemoteDataSource.getLiveScore();
        if (liveScoreModel != null) {
          List<LiveScore>? liveScore =
              liveScoreModel.map((e) => e.toEntity()).toList();
          return Right(liveScore);
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
