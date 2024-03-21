import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stadium.dart';

class GetStadiumUseCase {
  final TeamRepositories teamRepositories;
  GetStadiumUseCase({required this.teamRepositories});
  Future<Either<Failure, Stadium>?> call(int id) {
    return teamRepositories.getStadiumByID(id);
  }
}
