import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/table/get_table_of_a_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_player_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_team_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/a_team/team_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/a_team/team_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/player/player_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/player/player_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  GetTeamUseCase teamUseCase;
  TeamBloc({required this.teamUseCase}) : super(TeamInitial()) {
    on<TeamFetched>(onPlayerFetchedEvent);
  }
  Future onPlayerFetchedEvent(
      TeamFetched event, Emitter<TeamState> emit) async {
    try {
      emit(TeamLoading());
      final result = await teamUseCase.call(event.teamID);
      if (result != null) {
        result.fold((l) => emit(TeamFetchFail(message: l.message)),
            (r) => emit(TeamFetchSuccess(team: r)));
      } else {
        emit(TeamFetchFail());
      }
    } catch (e) {
      emit(TeamFetchFail());
    }
  }
}
