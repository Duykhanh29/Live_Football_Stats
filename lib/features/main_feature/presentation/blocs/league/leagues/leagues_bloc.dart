import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_all_leagues_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_leagues_of_country_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_state.dart';

class LeaguesBloc extends Bloc<LeaguesEvent, LeaguesState> {
  GetAllLeaguesUseCase? leaguesUseCase;
  GetLeagueOfCountryUseCase? leagueOfCountryUseCase;
  LeaguesBloc({this.leagueOfCountryUseCase, this.leaguesUseCase})
      : super(InitialLeagues()) {
    on<AllLeagueFetched>(onAllLeagueFetchedEvent);
    on<LeaguesOfACountryFetched>(onLeaguesOfACountryFetchedEvent);
  }
  Future onAllLeagueFetchedEvent(
      AllLeagueFetched event, Emitter<LeaguesState> emit) async {
    try {
      emit(LeaguesLoading());
      final result = await leaguesUseCase!.call();
      if (result != null) {
        result.fold((l) => emit(LeaguesFetchFail(failure: l)),
            (r) => emit(LeaguesFetchSuccess(r)));
      } else {
        emit(LeaguesFetchFail());
      }
    } catch (e) {
      emit(LeaguesFetchFail());
    }
  }

  Future onLeaguesOfACountryFetchedEvent(
      LeaguesOfACountryFetched event, Emitter<LeaguesState> emit) async {
    try {
      emit(LeaguesLoading());
      final result = await leagueOfCountryUseCase!.call(event.conutryId);
      if (result != null) {
        result.fold((l) => emit(LeaguesFetchFail()),
            (r) => emit(LeaguesFetchSuccess(r)));
      } else {
        emit(LeaguesFetchFail());
      }
    } catch (e) {
      emit(LeaguesFetchFail());
    }
  }
}
