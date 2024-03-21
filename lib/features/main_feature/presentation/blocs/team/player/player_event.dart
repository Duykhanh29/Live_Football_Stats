import 'package:equatable/equatable.dart';

class PlayerEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PlayerFetched extends PlayerEvent {
  int playerID;
  PlayerFetched({required this.playerID});
  @override
  // TODO: implement props
  List<Object?> get props => [playerID];
}
