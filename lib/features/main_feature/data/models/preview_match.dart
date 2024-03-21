// To parse this JSON data, do
//
//     final previewMatch = previewMatchFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/data/models/league_model_response.dart';
import 'package:live_football_stats/features/main_feature/data/models/stage_model_response.dart';
import 'package:live_football_stats/features/main_feature/data/models/team_model_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart'
    as matchEntity;

PreviewMatchModel previewMatchFromJson(String str) =>
    PreviewMatchModel.fromJson(json.decode(str));

String previewMatchToJson(PreviewMatchModel data) => json.encode(data.toJson());

class PreviewMatchModel {
  int id;
  String date;
  String time;
  int wordCount;
  CountryModel country;
  LeagueModelResponse league;
  StageModelResponse stage;
  Teams teams;
  MatchData matchData;
  List<PreviewContent> previewContent;

  PreviewMatchModel({
    required this.id,
    required this.date,
    required this.time,
    required this.wordCount,
    required this.country,
    required this.league,
    required this.stage,
    required this.teams,
    required this.matchData,
    required this.previewContent,
  });

  factory PreviewMatchModel.fromJson(Map<String, dynamic> json) =>
      PreviewMatchModel(
        id: json["id"],
        date: json["date"],
        time: json["time"],
        wordCount: json["word_count"],
        country: CountryModel.fromJson(json["country"]),
        league: LeagueModelResponse.fromJson(json["league"]),
        stage: StageModelResponse.fromJson(json["stage"]),
        teams: Teams.fromJson(json["teams"]),
        matchData: MatchData.fromJson(json["match_data"]),
        previewContent: List<PreviewContent>.from(
            json["preview_content"].map((x) => PreviewContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "time": time,
        "word_count": wordCount,
        "country": country.toJson(),
        "league": league.toJson(),
        "stage": stage.toJson(),
        "teams": teams.toJson(),
        "match_data": matchData.toJson(),
        "preview_content":
            List<dynamic>.from(previewContent.map((x) => x.toJson())),
      };
  matchEntity.MatchPreview toEntity() {
    return matchEntity.MatchPreview(
        id: id,
        date: date,
        time: time,
        wordCount: wordCount,
        country: country.toEntity(),
        league: league.toEntity(),
        stage: stage.toEntity(),
        teams: teams.toEntity(),
        matchData: matchData.totEntity(),
        previewContent: previewContent.map((e) => e.toEntity()).toList());
  }
}

class MatchData {
  Weather weather;
  double excitementRating;
  Prediction prediction;

  MatchData({
    required this.weather,
    required this.excitementRating,
    required this.prediction,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) => MatchData(
        weather: Weather.fromJson(json["weather"]),
        excitementRating: json["excitement_rating"]?.toDouble(),
        prediction: Prediction.fromJson(json["prediction"]),
      );

  Map<String, dynamic> toJson() => {
        "weather": weather.toJson(),
        "excitement_rating": excitementRating,
        "prediction": prediction.toJson(),
      };
  matchEntity.MatchData totEntity() {
    return matchEntity.MatchData(
        weather: weather.toEntity(),
        excitementRating: excitementRating,
        prediction: prediction.toEntity());
  }
}

class Prediction {
  String type;
  String choice;

  Prediction({
    required this.type,
    required this.choice,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        type: json["type"],
        choice: json["choice"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "choice": choice,
      };
  matchEntity.Prediction toEntity() {
    return matchEntity.Prediction(type: type, choice: choice);
  }
}

class Weather {
  double tempF;
  double tempC;
  String description;

  Weather({
    required this.tempF,
    required this.tempC,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        tempF: json["temp_f"]?.toDouble(),
        tempC: json["temp_c"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "temp_f": tempF,
        "temp_c": tempC,
        "description": description,
      };
  matchEntity.Weather toEntity() {
    return matchEntity.Weather(
        tempF: tempF, tempC: tempC, description: description);
  }
}

class PreviewContent {
  String name;
  String content;

  PreviewContent({
    required this.name,
    required this.content,
  });

  factory PreviewContent.fromJson(Map<String, dynamic> json) => PreviewContent(
        name: json["name"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "content": content,
      };
  matchEntity.PreviewContent toEntity() {
    return matchEntity.PreviewContent(name: name, content: content);
  }
}

class Teams {
  TeamModelResponse home;
  TeamModelResponse away;

  Teams({
    required this.home,
    required this.away,
  });

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        home: TeamModelResponse.fromJson(json["home"]),
        away: TeamModelResponse.fromJson(json["away"]),
      );

  Map<String, dynamic> toJson() => {
        "home": home.toJson(),
        "away": away.toJson(),
      };
  matchEntity.Teams toEntity() {
    return matchEntity.Teams(home: home.toEntity(), away: away.toEntity());
  }
}
