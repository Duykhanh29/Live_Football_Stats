import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';

class GetMatchUseCase {
  final MatchRepositories matchRepositories;
  GetMatchUseCase({required this.matchRepositories});
  Future<Either<Failure, Match>?> call(int id) {
    return matchRepositories.getMatchByID(id);
  }
}
