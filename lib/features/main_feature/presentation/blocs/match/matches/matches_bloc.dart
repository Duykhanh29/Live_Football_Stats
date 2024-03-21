import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_matches_of_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_upcoming_matches_uc.dart';

import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  GetMatchesOfLeagueUseCase? matchesOfLeagueUseCase;
  GetUpcomingMatchesUseCase? upcomingMatchesUseCase;
  MatchesBloc({this.matchesOfLeagueUseCase, this.upcomingMatchesUseCase})
      : super(InitialMatches()) {
    on<MatchesOfALeagueFetched>(onMatchesOfALeagueFetched);
    on<UpcomingMatchesFetched>(onUpcomingMatchesFetchedEvent);
  }
  Future onMatchesOfALeagueFetched(
      MatchesOfALeagueFetched event, Emitter<MatchesState> emit) async {
    try {
      emit(MatchesLoading());
      final result = await matchesOfLeagueUseCase!.call(event.leagueId);
      if (result != null) {
        result.fold((l) => emit(MatchesFetchFail(message: l.message)),
            (r) => emit(MatchesFetchSuccess(r)));
      } else {
        emit(MatchesFetchFail());
      }
    } catch (e) {
      emit(MatchesFetchFail());
    }
  }

  Future onUpcomingMatchesFetchedEvent(
      UpcomingMatchesFetched event, Emitter<MatchesState> emit) async {
    try {
      emit(MatchesLoading());
      final result = await upcomingMatchesUseCase!.call();
      if (result != null) {
        result.fold((l) => emit(MatchesFetchFail()),
            (r) => emit(UpcomingMatchesFetchSucess(r)));
      } else {
        emit(MatchesFetchFail());
      }
    } catch (e) {
      emit(MatchesFetchFail());
    }
  }
}
