import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart';

class TableState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TableInitial extends TableState {}

class TableLoading extends TableState {}

class TableFetchSuccess extends TableState {
  StandingEntities standingEntities;
  TableFetchSuccess({required this.standingEntities});
  @override
  // TODO: implement props
  List<Object?> get props => [standingEntities];
}

class TableFetchFail extends TableState {
  TableFetchFail();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
