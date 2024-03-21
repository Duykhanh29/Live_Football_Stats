import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart';

class GetMatchPreviewUseCase {
  final MatchRepositories matchRepositories;
  GetMatchPreviewUseCase({required this.matchRepositories});
  Future<Either<Failure, MatchPreview>?> call(int id) {
    return matchRepositories.getMacthPreview(id);
  }
}
