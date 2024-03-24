import 'package:equatable/equatable.dart';

class PreviewMatchEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PreviewMatchFetched extends PreviewMatchEvent {
  final int matchId;
  PreviewMatchFetched(this.matchId);
  @override
  // TODO: implement props
  List<Object?> get props => [matchId];
}
