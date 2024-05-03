import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/favourite/favourite_repositories.dart';

import '../../entities/favourite/favourite_league_entity.dart';

class GetListFavouriteLeagueUseCase {
  final FavouriteRepositories favouriteRepositories;
  GetListFavouriteLeagueUseCase(this.favouriteRepositories);
  Future<Either<Failure, FavouriteLeagueEntity>?> call(String uid) {
    return favouriteRepositories.getFavouriteLeagues(uid);
  }
}
