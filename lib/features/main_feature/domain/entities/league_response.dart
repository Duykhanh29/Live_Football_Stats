import 'package:equatable/equatable.dart';

class LeagueResponse extends Equatable {
  int id;
  String name;

  LeagueResponse({
    required this.id,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
