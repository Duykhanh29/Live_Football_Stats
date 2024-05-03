import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/favourite/favourite_repositories.dart';

import '../../../data/models/favourite/favourite_team_model.dart';

class AddFavouriteTeamUseCase {
  final FavouriteRepositories favouriteRepositories;
  AddFavouriteTeamUseCase(this.favouriteRepositories);
  Future<Either<Failure, bool>?> call(
      {required String uid, required TeamDataModel teamData}) {
    return favouriteRepositories.addFavouriteTeam(teamData: teamData, uid: uid);
  }
}
