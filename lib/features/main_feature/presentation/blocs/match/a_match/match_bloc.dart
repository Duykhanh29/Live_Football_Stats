import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_preview_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_matches_of_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_upcoming_matches_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_state.dart';

import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_state.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/entities/match.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  GetMatchUseCase? matchUseCase;
  GetMatchPreviewUseCase? matchPreviewUseCase;
  StreamController<Match>? streamController;
  bool isFetching = true;
  Stream<Match> get liveMatchStream {
    return streamController != null
        ? streamController!.stream
        : const Stream.empty();
  }

  MatchBloc({this.matchUseCase, this.matchPreviewUseCase})
      : super(InitialMatch()) {
    on<MatchFetched>(onMatchFetchedEvent);
  }
  Future onMatchFetchedEvent(
      MatchFetched event, Emitter<MatchState> emit) async {
    try {
      emit(MatchLoading());
      // while (isFetching) {
      //   if (!isFetching) break;
      final result = await matchUseCase!.call(event.matchId);
      if (result != null) {
        result.fold((l) {
          emit(MatchFetchFail(failure: l));
          // isFetching = false;
        }, (r) async {
          emit(MatchFetchSuccess(r));

          // streamController = StreamController<Match>();
          // streamController!.sink.add(r);
          // streamController?.close();
        });
      } else {
        emit(MatchFetchFail());
        // isFetching = false;
        // }
        // await Future.delayed(const Duration(seconds: 120));
      }
    } catch (e) {
      emit(MatchFetchFail());
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    streamController?.close();
    isFetching = false;
    print("Close the streamcontroller");
    return super.close();
  }
}
