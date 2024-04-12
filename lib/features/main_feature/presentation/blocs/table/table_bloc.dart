import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/table/get_table_of_a_league_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  GetTableOfALeagueUseCase tableOfALeagueUseCase;
  TableBloc({required this.tableOfALeagueUseCase}) : super(TableInitial()) {
    on<TableFetched>(onTableFetchedEvent);
  }
  Future onTableFetchedEvent(
      TableFetched event, Emitter<TableState> emit) async {
    try {
      emit(TableLoading());
      final result = await tableOfALeagueUseCase.call(event.leagueId);
      if (result != null) {
        result.fold((l) => emit(TableFetchFail(failure: l)),
            (r) => emit(TableFetchSuccess(standingEntities: r)));
      } else {
        emit(TableFetchFail());
      }
    } catch (e) {
      emit(TableFetchFail());
    }
  }
}
