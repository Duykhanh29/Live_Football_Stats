import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';

class GetMatchesByDateUseCase {
  MatchRepositories matchRepositories;
  GetMatchesByDateUseCase({required this.matchRepositories});
  Future<Either<Failure, List<LeagueMatches>>?> call(String date) {
    return matchRepositories.getMatchesByDate(date);
  }
}
