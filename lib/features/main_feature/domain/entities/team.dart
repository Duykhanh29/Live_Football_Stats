import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';

class Team extends Equatable {
  int? id;
  String? name;
  Country? country;
  StadiumResponse? stadium;
  bool isNation;
  Team({this.country, this.id, this.isNation = false, this.name, this.stadium});
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, country, stadium, isNation];
}

class StadiumResponse extends Equatable {
  int id;
  String name;
  String city;

  StadiumResponse({
    required this.id,
    required this.name,
    required this.city,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, city];
}
