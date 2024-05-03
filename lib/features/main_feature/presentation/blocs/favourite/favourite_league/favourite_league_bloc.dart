import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/core/constants/string_constants.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/favourite/add_favourite_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/favourite/delete_favourite_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/favourite/get_list_favourote_league_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/favourite/favourite_league/favourite_league_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/favourite/favourite_league/favourite_league_state.dart';

class FavouriteLeagueBloc
    extends Bloc<FavouriteLeagueEvent, FavouriteLeagueState> {
  AddFavouriteLeagueUseCase addFavouriteLeagueUseCase;
  DeleteFavouriteLeagueUseCase deleteFavouriteLeagueUseCase;
  GetListFavouriteLeagueUseCase getListFavouriteLeagueUseCase;
  FavouriteLeagueBloc(
      {required this.addFavouriteLeagueUseCase,
      required this.deleteFavouriteLeagueUseCase,
      required this.getListFavouriteLeagueUseCase})
      : super(InitialFavouriteLeague()) {
    on<AddFavouriteLeague>(onAddFavouriteLeagueEvent);
    on<DeleteFavouriteLeague>(onDeleteFavouriteLeagueEvent);
    on<FecthFavouriteLeagues>(onFecthFavouriteLeaguesEvent);
  }
  Future<void> onAddFavouriteLeagueEvent(
      AddFavouriteLeague event, Emitter<FavouriteLeagueState> emit) async {
    try {
      emit(LoadingFavouriteLeague());
      final result = await addFavouriteLeagueUseCase.call(
          uid: event.uid, leagueData: event.leagueData);
      if (result != null) {
        result.fold((l) {
          if (l is NetworkFailure) {
            emit(FavouriteLeagueFailWithNoInternet(
                message: StringConstants.noInternetConnection));
          } else {
            emit(FavouriteLeagueFetchedFail());
          }
        }, (r) {
          print("OKe I am load add");
          add(FecthFavouriteLeagues(uid: event.uid));
        });
      } else {
        emit(FavouriteLeagueFetchedFail());
      }
    } catch (e) {
      emit(FavouriteLeagueFetchedFail());
    }
  }

  Future<void> onDeleteFavouriteLeagueEvent(
      DeleteFavouriteLeague event, Emitter<FavouriteLeagueState> emit) async {
    try {
      emit(LoadingFavouriteLeague());
      final result = await deleteFavouriteLeagueUseCase.call(
          uid: event.uid, leagueID: event.leagueID);
      if (result != null) {
        result.fold((l) {
          if (l is NetworkFailure) {
            emit(FavouriteLeagueFailWithNoInternet(
                message: StringConstants.noInternetConnection));
          } else {
            emit(FavouriteLeagueFetchedFail());
          }
        }, (r) {
          print("OKe I am load delete");
          add(FecthFavouriteLeagues(uid: event.uid));
        });
      } else {
        emit(FavouriteLeagueFetchedFail());
      }
    } catch (e) {
      emit(FavouriteLeagueFetchedFail());
    }
  }

  Future<void> onFecthFavouriteLeaguesEvent(
      FecthFavouriteLeagues event, Emitter<FavouriteLeagueState> emit) async {
    try {
      emit(LoadingFavouriteLeague());
      final result = await getListFavouriteLeagueUseCase.call(event.uid);

      if (result != null) {
        result.fold((l) {
          emit(FavouriteLeagueFetchedFail());
        }, (r) {
          emit(FavouriteLeagueFetchedSucess(favouriteLeague: r));
        });
      } else {
        emit(FavouriteLeagueFetchedFail());
      }
    } catch (e) {
      emit(FavouriteLeagueFetchedFail());
    }
  }
}
