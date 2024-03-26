import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_matches_by_date_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_date_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_day_state.dart';

class MatchesByDateBloc extends Bloc<MatchesByDateEvent, MatchesByDateState> {
  GetMatchesByDateUseCase matchesByDateUseCase;
  MatchesByDateBloc({required this.matchesByDateUseCase})
      : super(InitialMatchesByDate()) {
    on<MatchesByDateFetched>(onMatchesByDateFetched);
  }
  Future onMatchesByDateFetched(
      MatchesByDateFetched event, Emitter<MatchesByDateState> emit) async {
    try {
      emit(MatchesByDateLoading());
      final result = await matchesByDateUseCase.call(event.date);
      if (result != null) {
        result.fold((l) => emit(MatchesByDateFetchFail(message: l.message)),
            (r) => emit(MatchesByDateFetchSuccess(r)));
      } else {
        emit(MatchesByDateFetchFail());
      }
    } catch (e) {
      emit(MatchesByDateFetchFail());
    }
  }
}
