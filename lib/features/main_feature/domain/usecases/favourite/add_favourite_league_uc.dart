import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/favourite/favourite_repositories.dart';

import '../../../data/models/favourite/favourite_league_model.dart';

class AddFavouriteLeagueUseCase {
  final FavouriteRepositories favouriteRepositories;
  AddFavouriteLeagueUseCase(this.favouriteRepositories);
  Future<Either<Failure, bool>?> call(
      {required String uid, required LeagueDataModel leagueData}) {
    return favouriteRepositories.addFavouriteLeague(
        leagueData: leagueData, uid: uid);
  }
}
