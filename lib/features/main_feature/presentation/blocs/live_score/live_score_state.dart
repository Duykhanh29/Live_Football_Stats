import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';

class LiveScoreState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LiveScoreInitial extends LiveScoreState {}

class LiveScoreLoading extends LiveScoreState {}

class LiveScoreFetchSuccess extends LiveScoreState {
  List<LiveScore>? liveScore;
  LiveScoreFetchSuccess({required this.liveScore});
  @override
  // TODO: implement props
  List<Object?> get props => [liveScore];
}

class LiveMatchFetchSuccess extends LiveScoreState {
  Match match;
  LiveMatchFetchSuccess({required this.match});
  @override
  // TODO: implement props
  List<Object?> get props => [match];
}

class LiveScoreFetchFail extends LiveScoreState {}
