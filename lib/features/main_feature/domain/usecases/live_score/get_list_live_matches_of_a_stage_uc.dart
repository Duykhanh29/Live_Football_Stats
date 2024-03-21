import 'package:live_football_stats/features/main_feature/domain/repositories/live_score_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';

class GetListLiveMatchesOfAStageUseCase {
  final LiveScoreRepositories liveScoreRepositories;
  GetListLiveMatchesOfAStageUseCase({required this.liveScoreRepositories});
  Future<Either<Failure, List<Match>>?> call(int leagueID, int stageID) {
    return liveScoreRepositories.getListLiveMatchesOfAStage(leagueID, stageID);
  }
}
