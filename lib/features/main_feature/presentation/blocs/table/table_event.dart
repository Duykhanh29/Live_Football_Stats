import 'package:equatable/equatable.dart';

class TableEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TableFetched extends TableEvent {
  int leagueId;
  TableFetched({required this.leagueId});
  @override
  // TODO: implement props
  List<Object?> get props => [leagueId];
}
