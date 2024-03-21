import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart'
    as upcoming;
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart'
    as preview;

abstract class MatchRepositories {
  Future<Either<Failure, LeagueMatches>?> getListMacthesByLeagueID(int id);
  Future<Either<Failure, Match>?> getMatchByID(int id);
  Future<Either<Failure, upcoming.UpcomingMatches>?> getUpcomingMacthes();
  Future<Either<Failure, preview.MatchPreview>?> getMacthPreview(int id);
}
