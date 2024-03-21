import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';

class CountryModel {
  final int? id;
  final String? name;
  CountryModel({required this.id, required this.name});
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(id: json['id'], name: json['name']);
  }
  Map<String, dynamic> toJson() => {"id": id, "name": name};
  Country toEntity() {
    return Country(id: id, name: name);
  }
}
