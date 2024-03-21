// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/features/main_feature/data/models/league_model_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/group.dart'
    as groupEntity;

GroupModel groupModelFromJson(String str) =>
    GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  GroupModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
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
  groupEntity.Group toEntity() {
    return groupEntity.Group(
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
  Stage stage;
  String name;

  Result({
    required this.id,
    required this.league,
    required this.season,
    required this.stage,
    required this.name,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        league: LeagueModelResponse.fromJson(json["league"]),
        season: json["season"],
        stage: Stage.fromJson(json["stage"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "league": league.toJson(),
        "season": season,
        "stage": stage.toJson(),
        "name": name,
      };
  groupEntity.Result toEntity() {
    return groupEntity.Result(
        id: id,
        league: league.toEntity(),
        name: name,
        season: season,
        stage: stage.toEntity());
  }
}

class Stage {
  int id;
  String name;

  Stage({
    required this.id,
    required this.name,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  groupEntity.Stage toEntity() {
    return groupEntity.Stage(id: id, name: name);
  }
}
