import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/core/platform/network_info.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/league_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';
import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/data/models/league.dart';

class LeagueRepoImpl implements LeagueRepositories {
  final NetworkInfo networkInfo;
  final LeagueRemoteDataSource leagueRemoteDataSource;
  LeagueRepoImpl(
      {required this.leagueRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<League>>?> getAllLeague() async {
    if (await networkInfo.isConnected) {
      try {
        final List<LeagueModel>? leaguesModel =
            await leagueRemoteDataSource.getAllLeague();
        if (leaguesModel != null) {
          final List<League> list =
              leaguesModel.map((e) => e.toEntity()).toList();
          return Right(list);
        } else {
          return null;
        }
      } catch (e) {
        if (e is TooManyRequestsFailure) {
          return Left(TooManyRequestsFailure(message: e.message));
        } else {
          return Left(ServerFailure(message: e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Country>?> getCountryByID(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final CountryModel? countryModel =
            await leagueRemoteDataSource.getCountryByID(id);
        if (countryModel != null) {
          final Country country = countryModel.toEntity();
          return Right(country);
        } else {
          return null;
        }
      } catch (e) {
        if (e is TooManyRequestsFailure) {
          return Left(TooManyRequestsFailure(message: e.message));
        } else {
          return Left(ServerFailure(message: e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, League>?> getLeagueByID(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final LeagueModel? leagueModel =
            await leagueRemoteDataSource.getLeagueByID(id);
        if (leagueModel != null) {
          final League league = leagueModel.toEntity();
          return Right(league);
        } else {
          return null;
        }
      } catch (e) {
        if (e is TooManyRequestsFailure) {
          return Left(TooManyRequestsFailure(message: e.message));
        } else {
          return Left(ServerFailure(message: e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<League>>?> getLeaguesByCountryId(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final List<LeagueModel>? leaguesModel =
            await leagueRemoteDataSource.getLeaguesOfACountry(id);
        if (leaguesModel != null) {
          final List<League> list =
              leaguesModel.map((e) => e.toEntity()).toList();
          return Right(list);
        } else {
          return null;
        }
      } catch (e) {
        if (e is TooManyRequestsFailure) {
          return Left(TooManyRequestsFailure(message: e.message));
        } else {
          return Left(ServerFailure(message: e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Country>>?> getListCountry() async {
    if (await networkInfo.isConnected) {
      try {
        final List<CountryModel>? listCountry =
            await leagueRemoteDataSource.getlistCountry();
        if (listCountry != null) {
          final List<Country> list =
              listCountry.map((e) => e.toEntity()).toList();
          return Right(list);
        } else {
          return null;
        }
      } catch (e) {
        if (e is TooManyRequestsFailure) {
          return Left(TooManyRequestsFailure(message: e.message));
        } else {
          return Left(ServerFailure(message: e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
