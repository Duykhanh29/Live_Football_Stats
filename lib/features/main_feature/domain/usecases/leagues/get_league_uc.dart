import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';

class GetLeagueUseCase {
  final LeagueRepositories leagueRepositories;
  GetLeagueUseCase(this.leagueRepositories);
  Future<Either<Failure, League>?> call(int id) {
    return leagueRepositories.getLeagueByID(id);
  }
}
