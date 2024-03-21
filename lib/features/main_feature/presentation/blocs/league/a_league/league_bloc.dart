import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_league_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_state.dart';

class LeagueBloc extends Bloc<LeagueEvent, LeagueState> {
  GetLeagueUseCase leagueUseCase;
  LeagueBloc({required this.leagueUseCase}) : super(IntialLeague()) {
    on<LeagueFetchedEvent>(onFetchLeague);
  }
  Future onFetchLeague(
      LeagueFetchedEvent leagueFetchedEvent, Emitter<LeagueState> emit) async {
    try {
      emit(LeagueLoading());
      final result = await leagueUseCase.call(leagueFetchedEvent.leagueId);
      if (result != null) {
        result.fold(
            (l) => emit(LeagueFetchFail()), (r) => emit(LeagueFetchSuccess(r)));
      } else {
        emit(LeagueFetchFail());
      }
    } catch (e) {
      emit(LeagueFetchFail());
    }
  }
}
