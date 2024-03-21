import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final int? id;
  final String? name;
  Country({required this.id, required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
