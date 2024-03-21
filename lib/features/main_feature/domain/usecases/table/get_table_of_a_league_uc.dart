import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/table_repositories.dart';

class GetTableOfALeagueUseCase {
  final TableRepositories tableRepositories;
  GetTableOfALeagueUseCase({required this.tableRepositories});
  Future<Either<Failure, StandingEntities>?> call(int id) {
    return tableRepositories.getTableByLeagueID(id);
  }
}
