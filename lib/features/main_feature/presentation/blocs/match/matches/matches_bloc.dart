import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_matches_of_league_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  GetMatchesOfLeagueUseCase? matchesOfLeagueUseCase;
  MatchesBloc({this.matchesOfLeagueUseCase}) : super(InitialMatches()) {
    on<MatchesOfALeagueFetched>(onMatchesOfALeagueFetched);
  }
  Future onMatchesOfALeagueFetched(
      MatchesOfALeagueFetched event, Emitter<MatchesState> emit) async {
    try {
      emit(MatchesLoading());
      final result = await matchesOfLeagueUseCase!.call(event.leagueId);
      if (result != null) {
        result.fold((l) => emit(MatchesFetchFail(failure: l)),
            (r) => emit(MatchesFetchSuccess(r)));
      } else {
        emit(MatchesFetchFail());
      }
    } catch (e) {
      emit(MatchesFetchFail());
    }
  }
}
