import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/live_score/get_live_match_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/live_score/get_live_score_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_state.dart';

class LiveScoreBloc extends Bloc<LiveScoreEvent, LiveScoreState> {
  GetLiveScoreUseCase liveScoreUseCase;
  GetLiveMatchUseCase liveMatchUseCase;
  LiveScoreBloc(
      {required this.liveMatchUseCase, required this.liveScoreUseCase})
      : super(LiveScoreInitial()) {
    on<LiveScoreFetched>(onLiveScoreFetchedEvent);
    on<LiveMatchFetched>(onLiveMatchFetchedEvent);
  }
  Future onLiveScoreFetchedEvent(
      LiveScoreFetched event, Emitter<LiveScoreState> emit) async {
    try {
      emit(LiveScoreLoading());
      final result = await liveScoreUseCase.call();
      if (result != null) {
        result.fold((l) => emit(LiveScoreFetchFail(failure: l)),
            (r) => emit(LiveScoreFetchSuccess(liveScore: r)));
      } else {
        emit(LiveScoreFetchFail());
      }
    } catch (e) {
      emit(LiveScoreFetchFail());
    }
  }

  Future onLiveMatchFetchedEvent(
      LiveMatchFetched event, Emitter<LiveScoreState> emit) async {
    try {
      final result = await liveMatchUseCase.call(
          event.leagueID, event.stageID, event.matchID);
      if (result != null) {
        result.fold((l) => emit(LiveScoreFetchFail()),
            (r) => emit(LiveMatchFetchSuccess(match: r)));
      } else {
        emit(LiveScoreFetchFail());
      }
    } catch (e) {
      emit(LiveScoreFetchFail());
    }
  }
}
