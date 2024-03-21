// To parse this JSON data, do
//
//     final TeamModel = TeamModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart'
    as teamEntity;

TeamModel TeamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String TeamModelToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
  int id;
  String name;
  CountryModel country;
  Stadium stadium;
  bool isNation;

  TeamModel({
    required this.id,
    required this.name,
    required this.country,
    required this.stadium,
    required this.isNation,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        id: json["id"],
        name: json["name"],
        country: CountryModel.fromJson(json["country"]),
        stadium: Stadium.fromJson(json["stadium"]),
        isNation: json["is_nation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country.toJson(),
        "stadium": stadium.toJson(),
        "is_nation": isNation,
      };
  teamEntity.Team toEntity() {
    return teamEntity.Team(
        country: country.toEntity(),
        id: id,
        isNation: isNation,
        name: name,
        stadium: stadium.toEntity());
  }
}

class Stadium {
  int id;
  String name;
  String city;

  Stadium({
    required this.id,
    required this.name,
    required this.city,
  });

  factory Stadium.fromJson(Map<String, dynamic> json) => Stadium(
        id: json["id"],
        name: json["name"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
      };
  teamEntity.StadiumResponse toEntity() {
    return teamEntity.StadiumResponse(id: id, name: name, city: city);
  }
}
