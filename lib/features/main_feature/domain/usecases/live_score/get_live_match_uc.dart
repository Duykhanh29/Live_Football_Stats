import 'package:live_football_stats/features/main_feature/domain/repositories/live_score_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';

class GetLiveMatchUseCase {
  final LiveScoreRepositories liveScoreRepositories;
  GetLiveMatchUseCase({required this.liveScoreRepositories});
  Future<Either<Failure, Match>?> call(int leagueID, int stageID, int matchID) {
    return liveScoreRepositories.getLiveMatchByID(leagueID, stageID, matchID);
  }
}
