import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';

class GetPlayerUseCase {
  final TeamRepositories teamRepositories;
  GetPlayerUseCase({required this.teamRepositories});
  Future<Either<Failure, Player>?> call(int id) {
    return teamRepositories.getPlayerByID(id);
  }
}
