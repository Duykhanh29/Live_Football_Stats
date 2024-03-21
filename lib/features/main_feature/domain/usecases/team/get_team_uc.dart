import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';

class GetTeamUseCase {
  final TeamRepositories teamRepositories;
  GetTeamUseCase({required this.teamRepositories});
  Future<Either<Failure, Team>?> call(int id) {
    return teamRepositories.getTeamByID(id);
  }
}
