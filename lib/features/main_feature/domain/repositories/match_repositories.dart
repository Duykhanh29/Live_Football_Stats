import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart'
    as upcoming;
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart'
    as preview;
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart';

import '../entities/head_to_head.dart';

abstract class MatchRepositories {
  Future<Either<Failure, LeagueMatches>?> getListMacthesByLeagueID(int id);
  Future<Either<Failure, Match>?> getMatchByID(int id);
  Future<Either<Failure, upcoming.UpcomingMatches>?> getUpcomingMacthes();
  Future<Either<Failure, preview.MatchPreview>?> getMacthPreview(int id);
  Future<Either<Failure, HeadToHead>?> getHeadtoHead(int team1ID, int team2ID);
  Future<Either<Failure, List<LeagueMatches>>?> getMatchesByDate(String date);
  Future<Either<Failure, LeagueMatches>?> getCurrentMatchesOfLeague(
      {required int leagueID, required String date});
}
