import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';

class GetMatchesOfLeagueUseCase {
  final MatchRepositories matchRepositories;
  GetMatchesOfLeagueUseCase({required this.matchRepositories});
  Future<Either<Failure, LeagueMatches>?> call(int id) {
    return matchRepositories.getListMacthesByLeagueID(id);
  }
}
