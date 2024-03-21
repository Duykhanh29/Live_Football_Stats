import 'package:equatable/equatable.dart';

class Season extends Equatable {
  bool? isActive;
  String? year;

  Season({
    required this.isActive,
    required this.year,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [year, isActive];
}
