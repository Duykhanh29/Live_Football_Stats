import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';

class GetCountryUseCase {
  final LeagueRepositories leagueRepositories;
  GetCountryUseCase(this.leagueRepositories);
  Future<Either<Failure, Country>?> call(int id) {
    return leagueRepositories.getCountryByID(id);
  }
}
