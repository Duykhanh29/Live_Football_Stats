// To parse this JSON data, do
//
//     final stage = stageFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/features/main_feature/data/models/league_model_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage.dart'
    as stageEntity;

StageModel stageFromJson(String str) => StageModel.fromJson(json.decode(str));

String stageToJson(StageModel data) => json.encode(data.toJson());

class StageModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  StageModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) => StageModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
  stageEntity.Stage toEntity() {
    return stageEntity.Stage(
        count: count,
        next: next,
        previous: previous,
        results: results.map((e) => e.toEntity()).toList());
  }
}

class Result {
  int id;
  LeagueModelResponse league;
  String season;
  String name;
  bool hasGroups;
  bool isActive;

  Result({
    required this.id,
    required this.league,
    required this.season,
    required this.name,
    required this.hasGroups,
    required this.isActive,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        league: LeagueModelResponse.fromJson(json["league"]),
        season: json["season"],
        name: json["name"],
        hasGroups: json["has_groups"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "league": league.toJson(),
        "season": season,
        "name": name,
        "has_groups": hasGroups,
        "is_active": isActive,
      };
  stageEntity.Result toEntity() {
    return stageEntity.Result(
        id: id,
        league: league.toEntity(),
        season: season,
        name: name,
        hasGroups: hasGroups,
        isActive: isActive);
  }
}
