// To parse this JSON data, do
//
//     final season = seasonFromJson(jsonString);

import 'dart:convert';
import 'package:live_football_stats/features/main_feature/domain/entities/season.dart';

SeasonModel seasonFromJson(String str) =>
    SeasonModel.fromJson(json.decode(str));

String seasonToJson(SeasonModel data) => json.encode(data.toJson());

class SeasonModel {
  bool? isActive;
  String? year;

  SeasonModel({
    required this.isActive,
    required this.year,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        isActive: json["is_active"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "is_active": isActive,
        "year": year,
      };
  Season toEntity() {
    return Season(isActive: isActive, year: year);
  }
}
