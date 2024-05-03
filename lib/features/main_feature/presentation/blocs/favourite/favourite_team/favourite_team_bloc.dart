import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/favourite/favourite_team/favourite_team_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/favourite/favourite_team/favourite_team_state.dart';

import '../../../../../../core/constants/string_constants.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../domain/usecases/favourite/add_favourite_team_uc.dart';
import '../../../../domain/usecases/favourite/delete_favourite_team_uc.dart';
import '../../../../domain/usecases/favourite/get_list_favourite_team_uc.dart';

class FavouriteTeamBloc extends Bloc<FavouriteTeamEvent, FavouriteTeamState> {
  AddFavouriteTeamUseCase addFavouriteTeamUseCase;
  DeleteFavouriteTeamUseCase deleteFavouriteTeamUseCase;
  GetListFavouriteTeamUseCase getListFavouriteTeamUseCase;
  FavouriteTeamBloc(
      {required this.addFavouriteTeamUseCase,
      required this.deleteFavouriteTeamUseCase,
      required this.getListFavouriteTeamUseCase})
      : super(InitialFavouriteTeam()) {
    on<AddFavouriteTeam>(onAddFavouriteTeamEvent);
    on<DeleteFavouriteTeam>(onDeleteFavouriteTeamEvent);
    on<FecthFavouriteTeams>(onFecthFavouriteTeamsEvent);
  }
  Future<void> onAddFavouriteTeamEvent(
      AddFavouriteTeam event, Emitter<FavouriteTeamState> emit) async {
    try {
      emit(LoadingFavouriteTeam());
      final result = await addFavouriteTeamUseCase.call(
          uid: event.uid, teamData: event.teamData);
      if (result != null) {
        result.fold((l) {
          if (l is NetworkFailure) {
            emit(FavouriteTeamFailWithNoInternet(
                message: StringConstants.noInternetConnection));
          } else {
            emit(FavouriteTeamFetchedFail());
          }
        }, (r) {
          add(FecthFavouriteTeams(uid: event.uid));
        });
      } else {
        emit(FavouriteTeamFetchedFail());
      }
    } catch (e) {
      emit(FavouriteTeamFetchedFail());
    }
  }

  Future<void> onDeleteFavouriteTeamEvent(
      DeleteFavouriteTeam event, Emitter<FavouriteTeamState> emit) async {
    try {
      emit(LoadingFavouriteTeam());
      final result = await deleteFavouriteTeamUseCase.call(
          uid: event.uid, teamID: event.teamID);
      if (result != null) {
        result.fold((l) {
          if (l is NetworkFailure) {
            emit(FavouriteTeamFailWithNoInternet(
                message: StringConstants.noInternetConnection));
          } else {
            emit(FavouriteTeamFetchedFail());
          }
        }, (r) {
          add(FecthFavouriteTeams(uid: event.uid));
        });
      } else {
        emit(FavouriteTeamFetchedFail());
      }
    } catch (e) {
      emit(FavouriteTeamFetchedFail());
    }
  }

  Future<void> onFecthFavouriteTeamsEvent(
      FecthFavouriteTeams event, Emitter<FavouriteTeamState> emit) async {
    try {
      emit(LoadingFavouriteTeam());
      final result = await getListFavouriteTeamUseCase.call(event.uid);
      if (result != null) {
        result.fold((l) {
          emit(FavouriteTeamFetchedFail());
        }, (r) {
          emit(FavouriteTeamFetchedSucess(favouriteTeam: r));
        });
      } else {
        emit(FavouriteTeamFetchedFail());
      }
    } catch (e) {
      emit(FavouriteTeamFetchedFail());
    }
  }
}
