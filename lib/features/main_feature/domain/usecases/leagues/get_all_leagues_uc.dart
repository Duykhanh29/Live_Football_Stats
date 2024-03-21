import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';

class GetAllLeaguesUseCase {
  final LeagueRepositories leagueRepositories;
  GetAllLeaguesUseCase(this.leagueRepositories);
  Future<Either<Failure, List<League>>?> call() {
    return leagueRepositories.getAllLeague();
  }
}
