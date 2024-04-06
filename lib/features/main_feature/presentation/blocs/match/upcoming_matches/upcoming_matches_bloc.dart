import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_upcoming_matches_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/upcoming_matches/upcoming_matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/upcoming_matches/upcoming_matches_state.dart';

class UpcomingMatchesBloc
    extends Bloc<UpcomingMatchesEvent, UpcomingMatchesState> {
  GetUpcomingMatchesUseCase? upcomingMatchesUseCase;
  UpcomingMatchesBloc({this.upcomingMatchesUseCase})
      : super(InitialUpcomingMatches()) {
    on<UpcomingMatchesFetched>(onUpcomingMatchesFetchedEvent);
  }

  Future onUpcomingMatchesFetchedEvent(
      UpcomingMatchesFetched event, Emitter<UpcomingMatchesState> emit) async {
    try {
      emit(UpcomingMatchesLoading());
      final result = await upcomingMatchesUseCase!.call();
      if (result != null) {
        result.fold((l) => emit(UpcomingMatchesFetchFail()),
            (r) => emit(UpcomingMatchesFetchSuccess(r)));
      } else {
        emit(UpcomingMatchesFetchFail());
      }
    } catch (e) {
      emit(UpcomingMatchesFetchFail());
    }
  }
}
