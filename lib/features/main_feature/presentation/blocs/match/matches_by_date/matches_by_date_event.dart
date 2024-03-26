import 'package:equatable/equatable.dart';

class MatchesByDateEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MatchesByDateFetched extends MatchesByDateEvent {
  final String date;
  MatchesByDateFetched(this.date);
  @override
  // TODO: implement props
  List<Object?> get props => [date];
}
