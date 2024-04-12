import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_head_to_head_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/head_to_head/head_to_head_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/head_to_head/head_to_head_state.dart';

class HeadToHeadBloc extends Bloc<HeadToHeadEvent, HeadToHeadState> {
  GetHeadToHeadUseCase headToHeadUseCase;
  HeadToHeadBloc({required this.headToHeadUseCase})
      : super(HeadToHeadInitial()) {
    on<HeadToHeadFetched>(onHeadToHeadFetchedEvent);
  }
  Future onHeadToHeadFetchedEvent(
      HeadToHeadFetched event, Emitter<HeadToHeadState> emit) async {
    try {
      emit(HeadToHeadLoading());
      final result = await headToHeadUseCase.call(event.team1ID, event.team2ID);
      if (result != null) {
        result.fold((l) => emit(HeadToHeadFetchFail(failure: l)),
            (r) => emit(HeadToHeadFetchSuccess(headToHead: r)));
      } else {
        emit(HeadToHeadFetchFail());
      }
    } catch (e) {
      emit(HeadToHeadFetchFail());
    }
  }
}
