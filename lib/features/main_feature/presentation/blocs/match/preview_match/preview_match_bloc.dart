import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_preview_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_uc.dart';

import 'package:live_football_stats/features/main_feature/presentation/blocs/match/preview_match/preview_match_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/preview_match/preview_match_state.dart';

class PreviewMatchBloc extends Bloc<PreviewMatchEvent, PreviewMatchState> {
  GetMatchUseCase? matchUseCase;
  GetMatchPreviewUseCase? matchPreviewUseCase;
  PreviewMatchBloc({this.matchUseCase, this.matchPreviewUseCase})
      : super(InitialPreviewMatch()) {
    on<PreviewMatchFetched>(onPreviewMatchFetchedEvent);
  }

  Future onPreviewMatchFetchedEvent(
      PreviewMatchFetched event, Emitter<PreviewMatchState> emit) async {
    try {
      emit(PreviewMatchLoading());
      final result = await matchPreviewUseCase!.call(event.matchId);
      if (result != null) {
        result.fold((l) => emit(PreviewMatchFetchFail(failure: l)),
            (r) => emit(MatchPreviewFetchSuccess(r)));
      } else {
        emit(PreviewMatchFetchFail());
      }
    } catch (e) {
      emit(PreviewMatchFetchFail());
    }
  }
}
