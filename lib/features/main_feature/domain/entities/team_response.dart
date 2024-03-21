import 'package:equatable/equatable.dart';

class TeamResponse extends Equatable {
  int id;
  String name;

  TeamResponse({
    required this.id,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
