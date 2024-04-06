import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/live_score_repositories.dart';

class GetLiveScoreUseCase {
  final LiveScoreRepositories liveScoreRepositories;
  GetLiveScoreUseCase({required this.liveScoreRepositories});
  Future<Either<Failure, List<LiveScore>>?> call() {
    return liveScoreRepositories.getLiveScore();
  }
}
