import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/core/platform/network_info.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/matches_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/models/head_to_head_model.dart';
import 'package:live_football_stats/features/main_feature/data/models/league_matches_model.dart';
import 'package:live_football_stats/features/main_feature/data/models/match_model.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/head_to_head.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart'
    as upcoming;
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart'
    as preview;
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';
import 'package:live_football_stats/features/main_feature/data/models/match_model.dart';
import 'package:live_football_stats/features/main_feature/data/models/preview_match.dart';
import 'package:live_football_stats/features/main_feature/data/models/upcoming_matches_of_a_league.dart';

class MatchRepoImpl implements MatchRepositories {
  NetworkInfo networkInfo;
  MatchRemoteDataSource matchRemoteDataSource;
  MatchRepoImpl(
      {required this.matchRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, LeagueMatches>?> getListMacthesByLeagueID(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final LeagueMatchesModel? listMatch =
            await matchRemoteDataSource.getListMacthesByLeagueID(id);
        if (listMatch != null) {
          LeagueMatches leagueMatches = listMatch.toEntity();
          return Right(leagueMatches);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, preview.MatchPreview>?> getMacthPreview(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final PreviewMatchModel? previewMatchModel =
            await matchRemoteDataSource.getMacthPreview(id);
        if (previewMatchModel != null) {
          final preview.MatchPreview previewMatch =
              previewMatchModel.toEntity();
          return Right(previewMatch);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Match>?> getMatchByID(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final MatchModel? matchModel =
            await matchRemoteDataSource.getMatchByID(id);
        if (matchModel != null) {
          final Match match = matchModel.toEntity();
          return Right(match);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, upcoming.UpcomingMatches>?>
      getUpcomingMacthes() async {
    if (await networkInfo.isConnected) {
      try {
        final UpcomingMatchesModel? upcomingMatchesModel =
            await matchRemoteDataSource.getListUpcomingMacthes();
        if (upcomingMatchesModel != null) {
          final upcoming.UpcomingMatches match =
              upcomingMatchesModel.toEntity();
          return Right(match);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, HeadToHead>?> getHeadtoHead(
      int team1ID, int team2ID) async {
    if (await networkInfo.isConnected) {
      try {
        final HeadToHeadModel? headToHeadModel =
            await matchRemoteDataSource.getHeadToHead(team1ID, team2ID);
        if (headToHeadModel != null) {
          final HeadToHead headToHead = headToHeadModel.toEntity();
          return Right(headToHead);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, LeagueMatches>?> getCurrentMatchesOfLeague(
      {required int leagueID, required String date}) async {
    if (await networkInfo.isConnected) {
      try {
        final LeagueMatchesModel? leagueMatchesModel =
            await matchRemoteDataSource.getCurrentMatchesOfLeague(
                leagueID: leagueID, date: date);
        if (leagueMatchesModel != null) {
          LeagueMatches leagueMatches = leagueMatchesModel.toEntity();
          return Right(leagueMatches);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<LeagueMatches>>?> getMatchesByDate(
      String date) async {
    if (await networkInfo.isConnected) {
      try {
        final List<LeagueMatchesModel>? listMatchesModel =
            await matchRemoteDataSource.getMatchesByDate(date);
        if (listMatchesModel != null) {
          if (listMatchesModel.isEmpty) {
            return Right([]);
          }
          List<LeagueMatches> list =
              listMatchesModel.map((e) => e.toEntity()).toList();
          return Right(list);
        }
        return null;
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
