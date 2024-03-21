import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';

class GetLeagueOfCountryUseCase {
  final LeagueRepositories leagueRepositories;
  GetLeagueOfCountryUseCase(this.leagueRepositories);
  Future<Either<Failure, List<League>>?> call(int id) {
    return leagueRepositories.getLeaguesByCountryId(id);
  }
}
