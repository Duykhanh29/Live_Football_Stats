import 'package:equatable/equatable.dart';

class LeaguesEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AllLeagueFetched extends LeaguesEvent {}

class LeaguesOfACountryFetched extends LeaguesEvent {
  final int conutryId;
  LeaguesOfACountryFetched(this.conutryId);
  @override
  // TODO: implement props
  List<Object?> get props => [conutryId];
}
