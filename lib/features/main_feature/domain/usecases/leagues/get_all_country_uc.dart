import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';

class GetAllCountryUseCase {
  final LeagueRepositories leagueRepositories;
  GetAllCountryUseCase(this.leagueRepositories);
  Future<Either<Failure, List<Country>>?> call() {
    return leagueRepositories.getListCountry();
  }
}
