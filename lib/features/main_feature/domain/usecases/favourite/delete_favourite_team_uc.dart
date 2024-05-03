import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/favourite/favourite_repositories.dart';

class DeleteFavouriteTeamUseCase {
  final FavouriteRepositories favouriteRepositories;
  DeleteFavouriteTeamUseCase(this.favouriteRepositories);
  Future<Either<Failure, bool>?> call(
      {required String uid, required String teamID}) {
    return favouriteRepositories.deleteAFavouriteTeam(uid: uid, teamID: teamID);
  }
}
