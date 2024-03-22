import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/head_to_head.dart';

class GetHeadToHeadUseCase {
  final MatchRepositories matchRepositories;
  GetHeadToHeadUseCase({required this.matchRepositories});
  Future<Either<Failure, HeadToHead>?> call(int team1Id, int team2Id) {
    return matchRepositories.getHeadtoHead(team1Id, team2Id);
  }
}
