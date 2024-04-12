import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/table/get_table_of_a_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_player_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/player/player_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/player/player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  GetPlayerUseCase playerUseCase;
  PlayerBloc({required this.playerUseCase}) : super(PlayerInitial()) {
    on<PlayerFetched>(onPlayerFetchedEvent);
  }
  Future onPlayerFetchedEvent(
      PlayerFetched event, Emitter<PlayerState> emit) async {
    try {
      emit(PlayerLoading());
      final result = await playerUseCase.call(event.playerID);
      if (result != null) {
        result.fold((l) => emit(PlayerFetchFail(failure: l)),
            (r) => emit(PlayerFetchSuccess(player: r)));
      } else {
        emit(PlayerFetchFail());
      }
    } catch (e) {
      emit(PlayerFetchFail());
    }
  }
}
