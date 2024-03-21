import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';

abstract class LeagueRepositories {
  Future<Either<Failure, List<Country>>?> getListCountry();
  Future<Either<Failure, Country>?> getCountryByID(int id);
  Future<Either<Failure, List<League>>?> getAllLeague();
  Future<Either<Failure, List<League>>?> getLeaguesByCountryId(int id);
  Future<Either<Failure, League>?> getLeagueByID(int id);
}
