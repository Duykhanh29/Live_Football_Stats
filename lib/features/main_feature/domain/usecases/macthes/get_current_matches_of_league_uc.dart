import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';

class GetCurrentMatchesOfLeagueUseCase {
  MatchRepositories matchRepositories;
  GetCurrentMatchesOfLeagueUseCase({required this.matchRepositories});
  Future<Either<Failure, LeagueMatches>?> call(
      {required String date, required int leagueID}) {
    return matchRepositories.getCurrentMatchesOfLeague(
        date: date, leagueID: leagueID);
  }
}
