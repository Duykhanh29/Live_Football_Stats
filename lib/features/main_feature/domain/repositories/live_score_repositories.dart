import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';

abstract class LiveScoreRepositories {
  Future<Either<Failure, List<Match>>?> getListLiveMatchesOfAStage(
      int leagueID, int stageID);
  Future<Either<Failure, List<Stage>>?> getListStage(int leagueID);
  Future<Either<Failure, Match>?> getLiveMatchByID(
      int leagueID, int stageID, int matchID);
  Future<Either<Failure, LiveScore>?> getLiveScore();
}
