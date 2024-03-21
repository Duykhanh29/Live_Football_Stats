import 'package:live_football_stats/features/main_feature/domain/repositories/live_score_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';

class GetListStageUseCase {
  final LiveScoreRepositories liveScoreRepositories;
  GetListStageUseCase({required this.liveScoreRepositories});
  Future<Either<Failure, List<Stage>>?> call(int leagueID) {
    return liveScoreRepositories.getListStage(leagueID);
  }
}
