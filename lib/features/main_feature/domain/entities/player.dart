import 'package:equatable/equatable.dart';

class Player extends Equatable {
  int? id;
  String? name;

  Player({
    required this.id,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
