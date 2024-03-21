import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';

class GetUpcomingMatchesUseCase {
  final MatchRepositories matchRepositories;
  GetUpcomingMatchesUseCase({required this.matchRepositories});
  Future<Either<Failure, UpcomingMatches>?> call() {
    return matchRepositories.getUpcomingMacthes();
  }
}
