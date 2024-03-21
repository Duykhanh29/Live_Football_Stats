import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';

class League extends Equatable {
  final int id;
  final String name;
  final bool isCup;
  final Country country;
  League(
      {required this.country,
      required this.id,
      this.isCup = false,
      required this.name});
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, isCup, country];
}
