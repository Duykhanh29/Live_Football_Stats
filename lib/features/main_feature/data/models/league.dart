import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';

class LeagueModel {
  final int id;
  final String name;
  final bool isCup;
  final CountryModel country;
  LeagueModel(
      {required this.country,
      required this.id,
      this.isCup = false,
      required this.name});
  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
        country: CountryModel.fromJson(json['country']),
        id: json['id'],
        name: json['name'],
        isCup: json['is_cup']);
  }
  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "country": country.toJson(), "is_cup": isCup};
  League toEntity() {
    return League(country: country.toEntity(), id: id, name: name);
  }
}
