import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/favourite/favourite_repositories.dart';

import '../../entities/favourite/favourite_team_entity.dart';

class GetListFavouriteTeamUseCase {
  final FavouriteRepositories favouriteRepositories;
  GetListFavouriteTeamUseCase(this.favouriteRepositories);
  Future<Either<Failure, FavouriteTeamEntity>?> call(String uid) {
    return favouriteRepositories.getFavouriteTeams(uid);
  }
}
