import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';

import '../../../../../../core/error/failures.dart';

class PlayerState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerFetchSuccess extends PlayerState {
  Player player;
  PlayerFetchSuccess({required this.player});
  @override
  // TODO: implement props
  List<Object?> get props => [player];
}

class PlayerFetchFail extends PlayerState {
  Failure? failure;
  PlayerFetchFail({this.failure});
  @override
  // TODO: implement props
  List<Object?> get props => [failure];
}
