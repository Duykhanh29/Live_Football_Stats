import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/transfer.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';

class GetTransferUseCase {
  final TeamRepositories teamRepositories;
  GetTransferUseCase({required this.teamRepositories});
  Future<Either<Failure, Transfer>?> call(int id) {
    return teamRepositories.getTransferByTeamID(id);
  }
}
