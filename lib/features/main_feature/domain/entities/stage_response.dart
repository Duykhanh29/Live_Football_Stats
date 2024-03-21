import 'package:equatable/equatable.dart';

class StageResponse extends Equatable {
  int id;
  String name;
  bool isActive;

  StageResponse({
    required this.id,
    required this.name,
    required this.isActive,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, isActive];
}
