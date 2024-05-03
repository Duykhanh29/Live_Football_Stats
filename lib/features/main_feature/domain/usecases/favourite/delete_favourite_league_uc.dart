import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/favourite/favourite_repositories.dart';

class DeleteFavouriteLeagueUseCase {
  final FavouriteRepositories favouriteRepositories;
  DeleteFavouriteLeagueUseCase(this.favouriteRepositories);
  Future<Either<Failure, bool>?> call(
      {required String uid, required String leagueID}) {
    return favouriteRepositories.deleteAFavouriteLeague(
        uid: uid, leagueID: leagueID);
  }
}
