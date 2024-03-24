import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_preview_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_matches_of_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_upcoming_matches_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_state.dart';

import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  GetMatchUseCase? matchUseCase;
  GetMatchPreviewUseCase? matchPreviewUseCase;
  MatchBloc({this.matchUseCase, this.matchPreviewUseCase})
      : super(InitialMatch()) {
    on<MatchFetched>(onMatchFetchedEvent);
  }
  Future onMatchFetchedEvent(
      MatchFetched event, Emitter<MatchState> emit) async {
    try {
      emit(MatchLoading());
      final result = await matchUseCase!.call(event.matchId);
      if (result != null) {
        result.fold(
            (l) => emit(MatchFetchFail()), (r) => emit(MatchFetchSuccess(r)));
      } else {
        emit(MatchFetchFail());
      }
    } catch (e) {
      emit(MatchFetchFail());
    }
  }
}
