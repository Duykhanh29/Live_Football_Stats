import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart';

abstract class TableRepositories {
  Future<Either<Failure, StandingEntities>?> getTableByLeagueID(int id);
}
